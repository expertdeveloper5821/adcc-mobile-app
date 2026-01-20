import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/services/api_client.dart';
import '../../../core/services/api_exception.dart';
import '../../../core/services/api_response.dart';
import '../../../core/constants/api_endpoints.dart';

/// Event model
class Event {
  final String id;
  final String title;
  final String? description;
  final String? mainImage; // Base64 image data URI
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
  final Map<String, dynamic>? additionalData;

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
  });

  /// Create Event from JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      mainImage: json['mainImage']?.toString(),
      eventDate: json['eventDate']?.toString(),
      eventTime: json['eventTime']?.toString(),
      address: json['address']?.toString(),
      maxParticipants: json['maxParticipants'] as int?,
      currentParticipants: json['currentParticipants'] as int?,
      minAge: json['minAge'] as int?,
      maxAge: json['maxAge'] as int?,
      youtubeLink: json['youtubeLink']?.toString(),
      status: json['status']?.toString(),
      createdBy: json['createdBy'] as Map<String, dynamic>?,
      additionalData: json,
    );
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

  /// Get participants string
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
      debugPrint('Response Data: $response.data');

      if (response.statusCode == 200 && response.data != null) {
        try {
          // Handle different response structures
          List<dynamic> eventsData = [];

          if (response.data is List) {
            // Direct array response
            debugPrint('Response is a List');
            eventsData = response.data as List<dynamic>;
          } else if (response.data is Map) {
            final data = response.data as Map<String, dynamic>;
            debugPrint('Response is a Map');
            debugPrint('Map keys: ${data.keys.toList()}');
            debugPrint('data key exists: ${data.containsKey('data')}');
            debugPrint('data type: ${data['data']?.runtimeType}');

            // Handle nested structure: {success: true, data: {events: [...]}}
            if (data['data'] != null && data['data'] is Map) {
              final nestedData = data['data'] as Map<String, dynamic>;
              debugPrint('Nested data keys: ${nestedData.keys.toList()}');
              debugPrint(
                  'events key exists: ${nestedData.containsKey('events')}');
              eventsData = nestedData['events'] as List<dynamic>? ?? [];
              debugPrint(
                  'Found ${eventsData.length} events in nested structure');
            }
            // Handle flat structure: {data: [...], success: true}
            else if (data['data'] != null && data['data'] is List) {
              debugPrint('Found events in flat data structure');
              eventsData = data['data'] as List<dynamic>;
            }
            // Handle direct events key: {events: [...]}
            else if (data['events'] != null && data['events'] is List) {
              debugPrint('Found events in direct events key');
              eventsData = data['events'] as List<dynamic>;
            } else {
              debugPrint('No events found in any expected structure');
              debugPrint('Available keys: ${data.keys.toList()}');
            }
          } else {
            debugPrint(
                'Response is neither List nor Map: ${response.data.runtimeType}');
          }

          debugPrint('Final eventsData length: ${eventsData.length}');

          if (eventsData.isEmpty) {
            return ApiResponse.error(
              message: 'No events found in response',
              statusCode: response.statusCode,
            );
          }

          final events = eventsData
              .map((json) {
                try {
                  return Event.fromJson(json as Map<String, dynamic>);
                } catch (e, stackTrace) {
                  // Log individual event parsing errors but continue
                  debugPrint('Error parsing event: $e');
                  debugPrint('Event JSON: $json');
                  debugPrint('Stack trace: $stackTrace');
                  return null;
                }
              })
              .whereType<Event>() // Filter out null values
              .toList();

          debugPrint('Successfully parsed ${events.length} events');

          if (events.isEmpty) {
            return ApiResponse.error(
              message: 'Failed to parse any events from response',
              statusCode: response.statusCode,
            );
          }

          return ApiResponse.success(
            data: events,
            statusCode: response.statusCode,
          );
        } catch (e, stackTrace) {
          debugPrint('=== Error in getEvents parsing ===');
          debugPrint('Error: $e');
          debugPrint('Stack trace: $stackTrace');
          return ApiResponse.error(
            message: 'Failed to parse events data: $e',
            statusCode: response.statusCode,
          );
        }
      } else {
        return ApiResponse.error(
          message: 'Failed to fetch events',
          statusCode: response.statusCode,
        );
      }
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

  /// Get event by ID
  Future<ApiResponse<Event>> getEventById(String eventId) async {
    try {
      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.eventById(eventId),
      );

      debugPrint('=== Event Details API Response ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data Type: ${response.data.runtimeType}');
      debugPrint('Response Data: $response.data');

      if (response.statusCode == 200 && response.data != null) {
        try {
          Map<String, dynamic> eventData;

          if (response.data is Map) {
            final data = response.data as Map<String, dynamic>;
            debugPrint('Response is a Map');
            debugPrint('Map keys: ${data.keys.toList()}');

            // Handle nested structure: {success: true, data: {event: {...}}}
            if (data['data'] != null && data['data'] is Map) {
              final nestedData = data['data'] as Map<String, dynamic>;
              debugPrint('Nested data keys: ${nestedData.keys.toList()}');

              // Check if event is nested inside data
              if (nestedData['event'] != null && nestedData['event'] is Map) {
                eventData = nestedData['event'] as Map<String, dynamic>;
                debugPrint('Found event in nested structure');
              } else {
                // Event data is directly in data
                eventData = nestedData;
                debugPrint('Event data is directly in data');
              }
            }
            // Handle flat structure: {data: {...}}
            else if (data['data'] != null && data['data'] is Map) {
              eventData = data['data'] as Map<String, dynamic>;
              debugPrint('Found event in flat data structure');
            }
            // Handle direct event object
            else {
              eventData = data;
              debugPrint('Event data is at root level');
            }
          } else {
            return ApiResponse.error(
              message: 'Invalid response format',
              statusCode: response.statusCode,
            );
          }

          debugPrint('Event data keys: ${eventData.keys.toList()}');
          final event = Event.fromJson(eventData);
          debugPrint('Successfully parsed event: ${event.title}');

          return ApiResponse.success(
            data: event,
            statusCode: response.statusCode,
          );
        } catch (e, stackTrace) {
          debugPrint('=== Error in getEventById parsing ===');
          debugPrint('Error: $e');
          debugPrint('Stack trace: $stackTrace');
          return ApiResponse.error(
            message: 'Failed to parse event data: $e',
            statusCode: response.statusCode,
          );
        }
      } else {
        return ApiResponse.error(
          message: 'Failed to fetch event',
          statusCode: response.statusCode,
        );
      }
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
