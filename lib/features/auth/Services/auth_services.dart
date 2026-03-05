import 'package:adcc/core/constants/api_endpoints.dart';
import 'package:adcc/core/services/api_client.dart';
import 'package:adcc/core/services/api_exception.dart';
import 'package:adcc/core/services/api_response.dart';
import 'package:adcc/core/services/token_storage_service.dart';
import 'package:dio/dio.dart';


class AuthService {
  static Future<ApiResponse<Map<String, dynamic>>> guestLogin() async {
    try {
      final response = await ApiClient.instance.post(
        ApiEndpoints.guestLogin,
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromResponse(
        response.data,
      );

      if (apiResponse.success && apiResponse.data != null) {
        final accessToken = apiResponse.data!['accessToken'];
        final refreshToken = apiResponse.data!['refreshToken'];

        if (accessToken != null) {
          await TokenStorageService.saveAccessToken(accessToken);
        }

        if (refreshToken != null) {
          await TokenStorageService.saveRefreshToken(refreshToken);
        }
      }

      return apiResponse;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}