import 'package:adcc/core/constants/api_endpoints.dart';
import 'package:adcc/core/services/api_client.dart';
import 'package:adcc/core/services/api_exception.dart';
import 'package:adcc/core/services/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CommunitiesService {
  final _apiClient = ApiClient.instance;
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

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? 'Failed to fetch communities',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);

      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  Future<ApiResponse<dynamic>> joinCommunity({
    required String communityId,
  }) async {
    try {
      debugPrint("🤝 [Join Community] API Hit Start...");
      debugPrint("🆔 Community ID: $communityId");

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.joinCommunity(communityId),
        data: {}, // join me body required nahi hai
      );

      debugPrint("✅ [Join Community] Response Status: ${response.statusCode}");
      debugPrint("📦 [Join Community] Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
          message: response.data?["message"] ?? "Community joined successfully",
        );
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to join community",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);

      debugPrint("❌ [Join Community] DioException: ${apiException.toString()}");

      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      debugPrint("❌ [Join Community] Unexpected Error: $e");

      return ApiResponse.error(
        message: "An unexpected error occurred: $e",
      );
    }
  }

  Future<ApiResponse<dynamic>> leaveCommunity({
    required String communityId,
    String? reason,
    String? feedback,
  }) async {
    try {
      debugPrint("🚪 [Leave Community] API Hit Start...");
      debugPrint("🆔 Community ID: $communityId");
      debugPrint("📌 Reason: $reason");
      debugPrint("📝 Feedback: $feedback");

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.leaveCommunity(communityId),
        data: {
          "reason": reason,
          "feedback": feedback,
        },
      );

      debugPrint("✅ [Leave Community] Response Status: ${response.statusCode}");
      debugPrint("📦 [Leave Community] Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
          message: response.data?["message"] ?? "Community left successfully",
        );
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to leave community",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);

      debugPrint("❌ [Leave Community] DioException: ${apiException.toString()}");

      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      debugPrint("❌ [Leave Community] Unexpected Error: $e");

      return ApiResponse.error(
        message: "An unexpected error occurred: $e",
      );
    }
  }

  Future<ApiResponse<dynamic>> getCityCommunities() {
    return getCommunities(
      queryParameters: {"category": "City Communities"},
    );
  }

  Future<ApiResponse<dynamic>> getGroupCommunities() {
    return getCommunities(
      queryParameters: {"category": "Group Communities"},
    );
  }

  Future<ApiResponse<dynamic>> getAwarenessCommunities() {
    return getCommunities(
      queryParameters: {"category": "Awareness & Special Communities"},
    );
  }

  Future<ApiResponse<dynamic>> getCommunitiesByType(String type) {
    return getCommunities(
      queryParameters: {"type": type},
    );
  }

  Future<ApiResponse<dynamic>> getCommunitiesByLocation(String location) {
    return getCommunities(
      queryParameters: {"location": location},
    );
  }
}
