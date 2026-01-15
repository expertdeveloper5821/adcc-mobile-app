/// API Endpoints constants
class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  // Base API version
  static const String v1 = '/v1';

  // Events endpoints
  static const String events = '$v1/events';
  static String eventById(String id) => '$v1/events/$id';

  // Authentication endpoints
  static const String auth = '$v1/auth';
  static const String authVerify = '$auth/verify';
  static const String authLogout = '$auth/logout';
}
