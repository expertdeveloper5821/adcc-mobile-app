import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing authentication tokens
class TokenStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userIdKey = 'user_id';
  // 🔥 NEW: Firebase token key
  static const String _firebaseTokenKey = 'firebase_id_token';

  /// Save access token (Backend JWT)
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    print('💾 [Storage] Access token saved');
  }

  /// Get access token (Backend JWT)
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Save refresh token (Backend Refresh Token)
  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
    print('💾 [Storage] Refresh token saved');
  }

  /// Get refresh token (Backend Refresh Token)
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // 🔥 NEW: Save Firebase ID Token
  static Future<void> saveFirebaseToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firebaseTokenKey, token);
    print('🔥 [Storage] Firebase token saved');
  }

  // 🔥 NEW: Get Firebase ID Token
  static Future<String?> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firebaseTokenKey);
  }

  /// Save token expiry timestamp
  static Future<void> saveTokenExpiry(int timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_tokenExpiryKey, timestamp);
  }

  /// Get token expiry timestamp
  static Future<int?> getTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_tokenExpiryKey);
  }

  /// Check if token is expired
  static Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return false;
    return DateTime.now().millisecondsSinceEpoch >= expiry;
  }
  
static Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_userIdKey, userId);
  print('👤 [Storage] UserId saved');
}

static Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(_userIdKey);
}
  /// Clear all tokens
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_tokenExpiryKey);
    await prefs.remove(_userIdKey);

    await prefs.remove(_firebaseTokenKey); // 🔥 Clear Firebase token too
    print('🗑️ [Storage] All tokens cleared');
  }

  /// Check if user is authenticated
  /// Returns true if token exists and is not expired (or if expiry is not set)
  static Future<bool> isAuthenticated() async {
    // 🔥 Change: Check Firebase token instead of backend token
    final token = await getFirebaseToken();
    // No token means not authenticated
    if (token == null || token.isEmpty) return false;

    // If token exists, check if it's expired (Firebase token expiry)
    // Firebase tokens expire in 1 hour, but we'll rely on Firebase to refresh
    return true;
  }
}