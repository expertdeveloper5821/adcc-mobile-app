import 'package:adcc/core/constants/api_endpoints.dart';
import 'package:adcc/core/services/api_client.dart';
import 'package:adcc/core/services/api_exception.dart';
import 'package:adcc/features/routes/Models/event_model.dart';
import 'package:adcc/features/routes/Models/track_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TracksService {
  final Dio _dio = ApiClient.instance.dio;

  Future<List<TrackModel>> getAllTracks() async {
    try {
      final response = await _dio.get(ApiEndpoints.tracks);

      final body = response.data;

      if (body is Map<String, dynamic>) {
        final data = body["data"];

        if (data is Map<String, dynamic>) {
          final tracksList = data["tracks"];

          if (tracksList is List) {
            return tracksList
                .map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }
      }

      return [];
    } on DioException catch (e) {
      debugPrint("❌ getAllTracks DioException: ${e.response?.data}");
      throw ApiException.fromDioException(e);
    } catch (e) {
      debugPrint("❌ getAllTracks error: $e");
      throw ApiException(message: "Something went wrong while fetching tracks.");
    }
  }

  Future<List<EventModel>> getTrackRelatedEvents(String trackId) async {
    try {
      final response = await _dio.get(ApiEndpoints.trackRelatedEvents(trackId));

      final body = response.data;

      if (body is Map<String, dynamic>) {
        final success = body["success"] ?? false;
        final data = body["data"];

        if (success && data is List) {
          return data
              .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } on DioException catch (e) {
      debugPrint("❌ getTrackRelatedEvents DioException: ${e.response?.data}");
      throw ApiException.fromDioException(e);
    } catch (e) {
      debugPrint("❌ getTrackRelatedEvents error: $e");
      throw ApiException(message: "Something went wrong while fetching track events.");
    }
  }
}