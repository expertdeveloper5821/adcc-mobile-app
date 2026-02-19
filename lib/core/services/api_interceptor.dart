import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'token_storage_service.dart';

class ApiInterceptor extends Interceptor {
  final bool enableLogging;
  final int maxRetries;
  final Duration retryDelay;

  ApiInterceptor({
    this.enableLogging = kDebugMode,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  // 🔥 Refresh handling (avoid multiple refresh calls)
  bool _isRefreshing = false;
  final List<Completer<String?>> _refreshQueue = [];

  // -----------------------------
  // REQUEST
  // -----------------------------
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // ✅ Always use backend access token for ALL APIs
      final accessToken = await TokenStorageService.getAccessToken();

      debugPrint("🔑 [Interceptor] Backend Access Token Present: ${accessToken != null}");

      // 🔥 Skip auth header only for login/verify endpoints if you want
      // (Optional - not required)
      final isVerifyApi = options.path.contains("/v1/auth/verify");
      final isRefreshApi = options.path.contains("/v1/auth/refresh");

      // For refresh api we don't need access token
      if (!isRefreshApi) {
        if (accessToken != null && accessToken.isNotEmpty) {
          // ✅ Access token goes here
          options.headers['Authorization'] = "Bearer $accessToken";
          debugPrint("✅ [Interceptor] Using Backend Access Token");
        } else {
          debugPrint("⚠️ [Interceptor] No backend access token found");
        }
      }

      // Default headers
      options.headers['Content-Type'] =
          options.headers['Content-Type'] ?? 'application/json';
      options.headers['Accept'] =
          options.headers['Accept'] ?? 'application/json';

      if (enableLogging) {
        _logRequest(options);
      }

      handler.next(options);
    } catch (e) {
      debugPrint("❌ [Interceptor] onRequest error: $e");
      handler.next(options);
    }
  }

  // -----------------------------
  // RESPONSE
  // -----------------------------
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (enableLogging) {
      _logResponse(response);
    }
    handler.next(response);
  }

  // -----------------------------
  // ERROR
  // -----------------------------
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (enableLogging) {
      _logError(err);
    }

    // 401 => refresh flow
    if (err.response?.statusCode == 401) {
      final response = await _handle401(err);

      if (response != null) {
        handler.resolve(response);
        return;
      }
    }

    // Retry on network errors
    if (_shouldRetry(err)) {
      final response = await _retryRequest(err.requestOptions);
      if (response != null) {
        handler.resolve(response);
        return;
      }
    }

    handler.next(err);
  }

  // -----------------------------
  // 401 HANDLER
  // -----------------------------
  Future<Response?> _handle401(DioException err) async {
    final requestOptions = err.requestOptions;

    // Prevent infinite refresh loop
    if (requestOptions.path.contains("/v1/auth/refresh")) {
      debugPrint("❌ [Refresh] Refresh endpoint returned 401. Logging out.");
      await TokenStorageService.clearTokens();
      return null;
    }

    // If refresh already running, wait for it
    if (_isRefreshing) {
      debugPrint("⏳ [Refresh] Already refreshing... waiting in queue");

      final completer = Completer<String?>();
      _refreshQueue.add(completer);

      final newAccessToken = await completer.future;

      if (newAccessToken == null || newAccessToken.isEmpty) {
        return null;
      }

      // Retry with refreshed token
      return _retryWithNewToken(requestOptions, newAccessToken);
    }

    _isRefreshing = true;

    try {
      debugPrint("🔄 [Refresh] Starting refresh token flow...");

      final newAccessToken = await _refreshAccessToken();

      if (newAccessToken == null || newAccessToken.isEmpty) {
        debugPrint("❌ [Refresh] Failed to refresh token. Logging out.");
        await TokenStorageService.clearTokens();
        _notifyRefreshQueue(null);
        return null;
      }

      debugPrint("✅ [Refresh] Token refreshed successfully!");

      // Notify waiting requests
      _notifyRefreshQueue(newAccessToken);

      // Retry current request
      return _retryWithNewToken(requestOptions, newAccessToken);
    } catch (e) {
      debugPrint("❌ [Refresh] Exception: $e");
      await TokenStorageService.clearTokens();
      _notifyRefreshQueue(null);
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  // -----------------------------
  // REFRESH TOKEN API CALL
  // -----------------------------
  Future<String?> _refreshAccessToken() async {
    final refreshToken = await TokenStorageService.getRefreshToken();

    debugPrint("🔁 [Refresh] Refresh Token Present: ${refreshToken != null}");

    if (refreshToken == null || refreshToken.isEmpty) {
      debugPrint("❌ [Refresh] No refresh token found");
      return null;
    }

    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: "https://adcc-b4f3.onrender.com",
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          validateStatus: (status) => status != null && status >= 200 && status < 300,
        ),
      );

      debugPrint("➡️ [Refresh] POST /v1/auth/refresh");

      final response = await dio.post(
        "/v1/auth/refresh",
        data: {
          "refreshToken": refreshToken,
        },
      );

      final body = response.data;

      debugPrint("📦 [Refresh] Response: $body");

      if (body is Map<String, dynamic>) {
        final data = body["data"];

        if (data is Map<String, dynamic>) {
          final newAccessToken = data["accessToken"] as String?;
          final newRefreshToken = data["refreshToken"] as String?;

          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            await TokenStorageService.saveAccessToken(newAccessToken);
            debugPrint("💾 [Refresh] New access token saved");
          }

          if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
            await TokenStorageService.saveRefreshToken(newRefreshToken);
            debugPrint("💾 [Refresh] New refresh token saved");
          }

          return newAccessToken;
        }
      }

      debugPrint("❌ [Refresh] Invalid refresh response format");
      return null;
    } catch (e) {
      debugPrint("❌ [Refresh] API call failed: $e");
      return null;
    }
  }

  // -----------------------------
  // RETRY ORIGINAL REQUEST WITH NEW TOKEN
  // -----------------------------
  Future<Response?> _retryWithNewToken(
    RequestOptions requestOptions,
    String newAccessToken,
  ) async {
    try {
      debugPrint("🔁 [Retry] Retrying request with new access token...");
      debugPrint("➡️ ${requestOptions.method} ${requestOptions.uri}");

      requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

      final dio = Dio(
        BaseOptions(
          baseUrl: requestOptions.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          validateStatus: (status) => status != null && status >= 200 && status < 300,
        ),
      );

      final response = await dio.fetch(requestOptions);
      debugPrint("✅ [Retry] Success!");
      return response;
    } catch (e) {
      debugPrint("❌ [Retry] Failed: $e");
      return null;
    }
  }

  // -----------------------------
  // NOTIFY QUEUE
  // -----------------------------
  void _notifyRefreshQueue(String? token) {
    for (final completer in _refreshQueue) {
      if (!completer.isCompleted) {
        completer.complete(token);
      }
    }
    _refreshQueue.clear();
  }

  // -----------------------------
  // RETRY ON NETWORK FAILURES
  // -----------------------------
  Future<Response?> _retryRequest(RequestOptions requestOptions) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        await Future.delayed(retryDelay * (retryCount + 1));

        final dio = Dio(
          BaseOptions(
            baseUrl: requestOptions.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            validateStatus: (status) =>
                status != null && status >= 200 && status < 300,
          ),
        );

        final response = await dio.fetch(requestOptions);

        debugPrint("🔁 [Retry] Network retry success after ${retryCount + 1} attempts");
        return response;
      } catch (_) {
        retryCount++;
        if (retryCount >= maxRetries) {
          debugPrint("❌ [Retry] Failed after $maxRetries attempts");
        }
      }
    }

    return null;
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }

  // -----------------------------
  // LOGS
  // -----------------------------
  void _logRequest(RequestOptions options) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ REQUEST');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ ${options.method} ${options.uri}');

    final authHeader = options.headers['Authorization'];
    if (authHeader != null) {
      debugPrint('│ Auth: 🔑 Backend Access Token');
    } else {
      debugPrint('│ Auth: ❌ None');
    }

    debugPrint('│ Headers: ${options.headers}');
    if (options.data != null) debugPrint('│ Body: ${options.data}');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('│ Query Parameters: ${options.queryParameters}');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  void _logResponse(Response response) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ RESPONSE');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ ${response.requestOptions.method} ${response.requestOptions.uri}');
    debugPrint('│ Status Code: ${response.statusCode}');
    debugPrint('│ Status Message: ${response.statusMessage}');
    if (response.data != null) {
      final dataStr = response.data.toString();
      final truncatedData =
          dataStr.length > 500 ? '${dataStr.substring(0, 500)}...' : dataStr;
      debugPrint('│ Data: $truncatedData');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

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
    debugPrint('└─────────────────────────────────────────────────────────');
  }
}
