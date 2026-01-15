import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'token_storage_service.dart';

/// Comprehensive API interceptor with logging, authentication, error handling, and retry logic
class ApiInterceptor extends Interceptor {
  final bool enableLogging;
  final int maxRetries;
  final Duration retryDelay;

  ApiInterceptor({
    this.enableLogging = kDebugMode,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add authentication token if available
    final token = await TokenStorageService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Add common headers
    options.headers['Content-Type'] =
        options.headers['Content-Type'] ?? 'application/json';
    options.headers['Accept'] = options.headers['Accept'] ?? 'application/json';

    // Log request in debug mode
    if (enableLogging) {
      _logRequest(options);
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // Log response in debug mode
    if (enableLogging) {
      _logResponse(response);
    }

    // Handle token refresh if needed (if your API returns new tokens in response)
    _handleTokenRefresh(response);

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Log error in debug mode
    if (enableLogging) {
      _logError(err);
    }

    // Handle specific error cases
    final errorResponse = await _handleError(err, handler);

    if (errorResponse != null) {
      handler.resolve(errorResponse);
      return;
    }

    handler.next(err);
  }

  /// Handle errors and potentially retry or refresh tokens
  Future<Response?> _handleError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // Handle 401 Unauthorized - Token expired or invalid
    if (err.response?.statusCode == 401) {
      return await _handleUnauthorized(err, handler);
    }

    // Handle network errors with retry logic
    if (_shouldRetry(err)) {
      return await _retryRequest(requestOptions, handler);
    }

    // Handle connection timeout
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return await _retryRequest(requestOptions, handler);
    }

    return null;
  }

  /// Handle 401 Unauthorized - Try to refresh token
  Future<Response?> _handleUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    // Check if we have a refresh token
    final refreshToken = await TokenStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      // No refresh token, clear all tokens and return error
      await TokenStorageService.clearTokens();
      return null;
    }

    try {
      // Attempt to refresh the token
      final dio = Dio(BaseOptions(
        baseUrl: requestOptions.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ));
      final refreshResponse = await dio.post(
        '/auth/refresh', // Adjust endpoint as needed
        data: {'refresh_token': refreshToken},
      );

      if (refreshResponse.statusCode == 200) {
        // Extract new tokens from response (adjust based on your API structure)
        final data = refreshResponse.data;
        if (data is Map<String, dynamic>) {
          final newAccessToken = data['access_token'] as String?;
          final newRefreshToken = data['refresh_token'] as String?;
          final expiresIn = data['expires_in'] as int?;

          if (newAccessToken != null) {
            await TokenStorageService.saveAccessToken(newAccessToken);
            if (newRefreshToken != null) {
              await TokenStorageService.saveRefreshToken(newRefreshToken);
            }
            if (expiresIn != null) {
              final expiry = DateTime.now()
                  .add(Duration(seconds: expiresIn))
                  .millisecondsSinceEpoch;
              await TokenStorageService.saveTokenExpiry(expiry);
            }

            // Retry the original request with new token
            requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final response = await dio.fetch(requestOptions);
            return response;
          }
        }
      }
    } catch (e) {
      // Refresh failed, clear tokens
      await TokenStorageService.clearTokens();
      if (enableLogging) {
        debugPrint('Token refresh failed: $e');
      }
    }

    return null;
  }

  /// Retry request on network errors
  Future<Response?> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        await Future.delayed(retryDelay * (retryCount + 1));

        final dio = Dio(BaseOptions(
          baseUrl: requestOptions.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ));
        final response = await dio.fetch(requestOptions);

        if (enableLogging) {
          debugPrint(
              'Request retry successful after ${retryCount + 1} attempts');
        }

        return response;
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          if (enableLogging) {
            debugPrint('Request failed after $maxRetries retries: $e');
          }
          break;
        }
      }
    }

    return null;
  }

  /// Check if error should trigger a retry
  bool _shouldRetry(DioException err) {
    // Don't retry server errors (5xx) - they're server-side issues
    // Only retry network/timeout errors
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }

  /// Handle token refresh from response (if API returns tokens in response)
  void _handleTokenRefresh(Response response) {
    // If your API returns new tokens in response headers or body, handle it here
    // Example:
    // final newToken = response.headers.value('X-New-Access-Token');
    // if (newToken != null) {
    //   TokenStorageService.saveAccessToken(newToken);
    // }
  }

  /// Log request details
  void _logRequest(RequestOptions options) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ REQUEST');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ ${options.method} ${options.uri}');
    debugPrint('│ Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('│ Body: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint('│ Query Parameters: ${options.queryParameters}');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  /// Log response details
  void _logResponse(Response response) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ RESPONSE');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint(
        '│ ${response.requestOptions.method} ${response.requestOptions.uri}');
    debugPrint('│ Status Code: ${response.statusCode}');
    debugPrint('│ Status Message: ${response.statusMessage}');
    if (response.data != null) {
      final dataStr = response.data.toString();
      // Limit log length to avoid cluttering
      final truncatedData =
          dataStr.length > 500 ? '${dataStr.substring(0, 500)}...' : dataStr;
      debugPrint('│ Data: $truncatedData');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  /// Log error details
  void _logError(DioException err) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ ERROR');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ ${err.requestOptions.method} ${err.requestOptions.uri}');
    debugPrint('│ Error Type: ${err.type}');
    debugPrint('│ Error Message: ${err.message}');
    if (err.response != null) {
      debugPrint('│ Status Code: ${err.response?.statusCode}');
      debugPrint('│ Status Message: ${err.response?.statusMessage}');
      if (err.response?.data != null) {
        debugPrint('│ Error Data: ${err.response?.data}');
      }
    }
    if (err.error != null) {
      debugPrint('│ Error: ${err.error}');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }
}
