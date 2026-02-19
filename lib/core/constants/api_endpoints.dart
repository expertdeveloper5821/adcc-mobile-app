/// API Endpoints constants
class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  // Base API version
  static const String v1 = '/v1';

  // Events endpoints
  static const String events = '$v1/events';
  static String eventById(String id) => '$v1/events/$id';
  static String joinEvent(String eventId) => '$events/$eventId/joinEvent';
  static String cancelEvent(String eventId) => '$events/$eventId/cancel';
  // Community endpoints
  static const String communities = '$v1/communities';
  static String communityById(String id) => '$communities/$id';
  static String leaveCommunity(String id) => '$communities/$id/leave';
  static String joinCommunity(String id) => '$communities/$id/join';

  // ✅ Tracks
  static const String tracks = '$v1/tracks';

  
  // Authentication endpoints
  static const String auth = '$v1/auth';
  static const String authVerify = '$auth/verify';
  static const String authLogout = '$auth/logout';
}
