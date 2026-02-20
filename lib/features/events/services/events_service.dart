import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_exception.dart';
import '../../../core/services/api_response.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/services/token_storage_service.dart';

/// Event model
class Event {
  final String id;
  final String title;
  final String? description;

  /// Base64 image data URI
  final String? mainImage;

  final String? eventDate;
  final String? eventTime;
  final String? address;

  final int? maxParticipants;
  final int? currentParticipants;

  final int? minAge;
  final int? maxAge;

  final String? youtubeLink;
  final String? status;

  final Map<String, dynamic>? createdBy;

  /// Full raw JSON store (for future usage)
  final Map<String, dynamic>? additionalData;

  /// Local derived category (backend doesn't send category currently)
  final String? derivedCategory;

  Event({
    required this.id,
    required this.title,
    this.description,
    this.mainImage,
    this.eventDate,
    this.eventTime,
    this.address,
    this.maxParticipants,
    this.currentParticipants,
    this.minAge,
    this.maxAge,
    this.youtubeLink,
    this.status,
    this.createdBy,
    this.additionalData,
    this.derivedCategory,
  });

  /// Create Event from JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    final title = json['title']?.toString() ?? '';

    return Event(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: title,
      description: json['description']?.toString(),
      mainImage: json['mainImage']?.toString(),
      eventDate: json['eventDate']?.toString(),
      eventTime: json['eventTime']?.toString(),
      address: json['address']?.toString(),
      maxParticipants: json['maxParticipants'] is int
          ? json['maxParticipants'] as int
          : int.tryParse(json['maxParticipants']?.toString() ?? ''),
      currentParticipants: json['currentParticipants'] is int
          ? json['currentParticipants'] as int
          : int.tryParse(json['currentParticipants']?.toString() ?? ''),
      minAge: json['minAge'] is int
          ? json['minAge'] as int
          : int.tryParse(json['minAge']?.toString() ?? ''),
      maxAge: json['maxAge'] is int
          ? json['maxAge'] as int
          : int.tryParse(json['maxAge']?.toString() ?? ''),
      youtubeLink: json['youtubeLink']?.toString(),
      status: json['status']?.toString(),
      createdBy: json['createdBy'] is Map<String, dynamic>
          ? json['createdBy'] as Map<String, dynamic>
          : null,
      additionalData: json,
      derivedCategory: _deriveCategoryFromTitle(title),
    );
  }

  /// Category derive helper (backend doesn't send category)
  static String _deriveCategoryFromTitle(String title) {
    final t = title.toLowerCase();

    if (t.contains('family') || t.contains('kids')) return 'Family & Kids';
    if (t.contains('shop')) return 'Shop';
    if (t.contains('community') || t.contains('ride')) return 'Community Rides';

    return 'Community Rides';
  }

  /// Get formatted date string
  String? get formattedDate {
    if (eventDate == null) return null;
    try {
      final dateTime = DateTime.parse(eventDate!);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}';
    } catch (e) {
      return eventDate;
    }
  }

  /// IMPORTANT:
  /// EventDetailsScreen is using this.
  String get participantsString {
    if (currentParticipants != null && maxParticipants != null) {
      return '$currentParticipants/$maxParticipants';
    } else if (currentParticipants != null) {
      return '$currentParticipants';
    } else if (maxParticipants != null) {
      return '0/$maxParticipants';
    }
    return '0';
  }

  /// Convert Event to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'mainImage': mainImage,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'address': address,
      'maxParticipants': maxParticipants,
      'currentParticipants': currentParticipants,
      'minAge': minAge,
      'maxAge': maxAge,
      'youtubeLink': youtubeLink,
      'status': status,
      'createdBy': createdBy,
      'derivedCategory': derivedCategory,
      ...?additionalData,
    };
  }
}

/// Events Service for API calls
class EventsService {
  final _apiClient = ApiClient.instance;

  /// Get all events
  Future<ApiResponse<List<Event>>> getEvents({
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.events,
        queryParameters: queryParameters,
      );

      debugPrint('=== Events API Response ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data Type: ${response.data.runtimeType}');
      debugPrint('Response Data: ${response.data}');

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        try {
          List<dynamic> eventsData = [];

          if (response.data is List) {
            eventsData = response.data as List<dynamic>;
          } else if (response.data is Map) {
            final data = response.data as Map<String, dynamic>;

            if (data['data'] != null && data['data'] is Map) {
              final nestedData = data['data'] as Map<String, dynamic>;
              eventsData = nestedData['events'] as List<dynamic>? ?? [];
            } else if (data['events'] != null && data['events'] is List) {
              eventsData = data['events'] as List<dynamic>;
            } else if (data['data'] != null && data['data'] is List) {
              eventsData = data['data'] as List<dynamic>;
            }
          }

          debugPrint('Final eventsData length: ${eventsData.length}');

          final events = eventsData
              .map((json) {
                try {
                  return Event.fromJson(json as Map<String, dynamic>);
                } catch (e, st) {
                  debugPrint('Error parsing event: $e');
                  debugPrint('Stack: $st');
                  debugPrint('JSON: $json');
                  return null;
                }
              })
              .whereType<Event>()
              .toList();

          if (events.isEmpty) {
            return ApiResponse.error(
              message: 'No events parsed from response',
              statusCode: response.statusCode,
            );
          }

          return ApiResponse.success(
            data: events,
            statusCode: response.statusCode,
          );
        } catch (e, st) {
          debugPrint('=== Error in getEvents parsing ===');
          debugPrint('Error: $e');
          debugPrint('Stack: $st');

          return ApiResponse.error(
            message: 'Failed to parse events data: $e',
            statusCode: response.statusCode,
          );
        }
      }

      return ApiResponse.error(
        message: 'Failed to fetch events',
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

  Future<ApiResponse<dynamic>> joinEvent({
    required String eventId,
  }) async {
    try {
    

    
      String? userId = await TokenStorageService.getUserId();

      userId ??= "69959a9430e2025c6208df05";

      final body = {
        "eventId": eventId,
        "userId": userId,
        "status": "joined",
      };


      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.joinEvent(eventId),
        data: body,
      );

     
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null &&
          response.data["success"] == true) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
          message: response.data["message"] ?? "Registered successfully",
        );
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to register",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);

      debugPrint("❌ [Join Event] DioException: ${apiException.toString()}");

      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
      debugPrint("❌ [Join Event] Unexpected Error: $e");
      return ApiResponse.error(message: "Unexpected error: $e");
    }
  }

  ///  CANCEL EVENT (FIXED)
  Future<ApiResponse<dynamic>> cancelEvent({
    required String eventId,
    required String reason,
  }) async {
    try {
   

      String? userId = await TokenStorageService.getUserId();
      userId ??= "69959a9430e2025c6208df05";

      final body = {
        "eventId": eventId,
        "userId": userId,
        "status": "cancelled",
        "reason": reason,
      };

    

      final response = await _apiClient.post<dynamic>(
        ApiEndpoints.cancelEvent(eventId),
        data: body,
      );

    

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null &&
          response.data["success"] == true) {
        return ApiResponse.success(
          data: response.data,
          statusCode: response.statusCode,
          message: response.data["message"] ?? "Registration cancelled",
        );
      }

      return ApiResponse.error(
        message: response.data?["message"] ?? "Failed to cancel registration",
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final apiException = ApiException.fromDioException(e);


      return ApiResponse.error(
        message: apiException.toString(),
        statusCode: apiException.statusCode,
      );
    } catch (e) {
    
      return ApiResponse.error(message: "Unexpected error: $e");
    }
  }

  /// Get event by ID
  Future<ApiResponse<Event>> getEventById(String eventId) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.eventById(eventId),
      );

    

      if (response.statusCode == 200 && response.data != null) {
        try {
          Map<String, dynamic> eventData;

          if (response.data is Map) {
            final data = response.data as Map<String, dynamic>;

            if (data['data'] != null && data['data'] is Map) {
              final nestedData = data['data'] as Map<String, dynamic>;

              if (nestedData['event'] != null && nestedData['event'] is Map) {
                eventData = nestedData['event'] as Map<String, dynamic>;
              } else {
                eventData = nestedData;
              }
            } else {
              eventData = data;
            }
          } else {
            return ApiResponse.error(
              message: 'Invalid response format',
              statusCode: response.statusCode,
            );
          }

          final event = Event.fromJson(eventData);

          return ApiResponse.success(
            data: event,
            statusCode: response.statusCode,
          );
        } catch (e, st) {
        
          return ApiResponse.error(
            message: 'Failed to parse event data: $e',
            statusCode: response.statusCode,
          );
        }
      }

      return ApiResponse.error(
        message: 'Failed to fetch event',
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
}
