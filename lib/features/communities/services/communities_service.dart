import 'package:adcc/core/constants/api_endpoints.dart';
import 'package:adcc/core/services/api_client.dart';
import 'package:adcc/core/services/api_response.dart';
import 'package:adcc/core/services/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Communities Service for API calls
class CommunitiesService {
  final _apiClient = ApiClient.instance;

  /// Get all communities
  Future<ApiResponse<dynamic>> getCommunities({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.communities,
        queryParameters: queryParameters,
      );

      debugPrint('=== Communities API Response ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data Type: ${response.data.runtimeType}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // Just log the response for now, user will handle filtering later
        debugPrint('=== Communities Response Structure ===');
        if (response.data is List) {
          debugPrint('Response is a List with ${(response.data as List).length} items');
        } else if (response.data is Map) {
          final data = response.data as Map<String, dynamic>;
          debugPrint('Response is a Map');
          debugPrint('Map keys: ${data.keys.toList()}');
          if (data.containsKey('data')) {
            debugPrint('Data key exists, type: ${data['data']?.runtimeType}');
          }
          if (data.containsKey('communities')) {
            debugPrint('Communities key exists, type: ${data['communities']?.runtimeType}');
          }
        }

        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          message: 'Failed to fetch communities',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);
      debugPrint('=== Communities API Error ===');
      debugPrint('Error: ${apiException.toString()}');
      debugPrint('Status Code: ${apiException.statusCode}');
      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      debugPrint('=== Communities API Unexpected Error ===');
      debugPrint('Error: $e');
      return ApiResponse.error(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Get community by ID
  Future<ApiResponse<dynamic>> getCommunityById(String communityId) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.communityById(communityId),
      );

      debugPrint('=== Community Details API Response ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data Type: ${response.data.runtimeType}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          message: 'Failed to fetch community details',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);
      debugPrint('=== Community Details API Error ===');
      debugPrint('Error: ${apiException.toString()}');
      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      debugPrint('=== Community Details API Unexpected Error ===');
      debugPrint('Error: $e');
      return ApiResponse.error(
        message: 'An unexpected error occurred: $e',
      );
    }
  }
}
