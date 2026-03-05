import 'package:adcc/core/constants/api_endpoints.dart';
import 'package:adcc/core/services/api_client.dart';
import 'package:adcc/core/services/api_exception.dart';
import 'package:adcc/core/services/api_response.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:dio/dio.dart';

class CommunitiesService {
  final _apiClient = ApiClient.instance;

 Future<ApiResponse<dynamic>> getCommunities({
  Map<String, dynamic>? queryParameters,
}) async {
  const endpoint = ApiEndpoints.communities;

  try {
    print("============================================");
    print("🌍 API CALL STARTED → GET $endpoint");
    print("📦 Query Params → $queryParameters");

    final response = await _apiClient.get<dynamic>(
      endpoint,
      queryParameters: queryParameters,
    );

    print("✅ STATUS CODE → ${response.statusCode}");
    print("📥 RAW RESPONSE DATA ↓↓↓");
    print(response.data);

    print("============================================");

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
    print("❌ DIO ERROR OCCURRED");
    print("Status Code → ${e.response?.statusCode}");
    print("Error Data → ${e.response?.data}");
    print("Error Message → ${e.message}");

    final apiException = ApiException.fromDioException(e);

    return ApiResponse.error(
      message: apiException.toString(),
      statusCode: apiException.statusCode,
    );
  } catch (e) {
    print("❌ UNEXPECTED ERROR → $e");

    return ApiResponse.error(
      message: 'An unexpected error occurred',
    );
  }
}
  Future<ApiResponse<dynamic>> joinCommunity({
    required String communityId,
  }) async {
    final endpoint = ApiEndpoints.joinCommunity(communityId);

    try {
      final response = await _apiClient.post<dynamic>(
        endpoint,
        data: {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data["success"] == true) {
          return ApiResponse.success(
            data: response.data,
            statusCode: response.statusCode,
            message: response.data?["message"] ??
                "Community joined successfully",
          );
        }
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to join community",
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
        message: "An unexpected error occurred",
      );
    }
  }

   Future<ApiResponse<bool>> getCommunityMemberStatus({
  required String communityId,
}) async {
  final endpoint =
      ApiEndpoints.communityMemberStatus(communityId);

  try {
    final response = await _apiClient.get<dynamic>(endpoint);

    if (response.statusCode == 200 &&
        response.data != null &&
        response.data["success"] == true) {
      
      final status =
          response.data["data"]?["status"]?.toString();

      final isJoined = status == "joined";

      return ApiResponse.success(
        data: isJoined,
        statusCode: response.statusCode,
      );
    }

    return ApiResponse.error(
      message:
          response.data?["message"] ??
              "Failed to fetch member status",
      statusCode: response.statusCode,
    );
  } on DioException catch (e) {
    final apiException =
        ApiException.fromDioException(e);

    return ApiResponse.error(
      message: apiException.toString(),
      statusCode: apiException.statusCode,
    );
  } catch (e) {
    return ApiResponse.error(
      message: "Unexpected error occurred",
    );
  }
}

  Future<ApiResponse<dynamic>> leaveCommunity({
    required String communityId,
    String? reason,
    String? feedback,
  }) async {
    final endpoint = ApiEndpoints.leaveCommunity(communityId);

    try {
      final requestData = {
        if (reason != null) "reason": reason,
        if (feedback != null) "feedback": feedback,
      };

      final response = await _apiClient.post<dynamic>(
        endpoint,
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data["success"] == true) {
          return ApiResponse.success(
            data: response.data,
            statusCode: response.statusCode,
            message: response.data?["message"] ??
                "Community left successfully",
          );
        }
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to leave community",
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
        message: "An unexpected error occurred",
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

Future<ApiResponse<CommunityModel>> getCommunityById({
  required String communityId,
}) async {
  final endpoint = ApiEndpoints.communityById(communityId);

  try {
    print("🔵 Calling API: $endpoint");

    final response = await _apiClient.get<dynamic>(endpoint);

    print("🟢 RAW API RESPONSE:");
    print(response.data);

if ((response.statusCode == 200 || response.statusCode == 201) &&
    response.data != null &&
    response.data["success"] == true) {

      final community = CommunityModel.fromJson(response.data["data"]);

      return ApiResponse.success(
        data: community,
        statusCode: response.statusCode,
      );
    }

    return ApiResponse.error(
      message: response.data?["message"] ?? "Failed to fetch community",
      statusCode: response.statusCode,
    );
  } catch (e) {
    print("🔴 ERROR IN getCommunityById: $e");
    return ApiResponse.error(
      message: "Unexpected error occurred",
    );
  }
}

}