import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'access_token';

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to save token: ${e.toString()}');
    }
  }

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to retrieve token: ${e.toString()}');
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to delete token: ${e.toString()}');
    }
  }

  // Optional: Add a method to check if the token is valid (requires decoding the token to check expiry)
  static Future<bool> isTokenValid() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        return false;
      }
      // Example of decoding and validating token expiry (requires a JWT library)
      // final decodedToken = JwtDecoder.decode(token);
      // final expiryDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      // return expiryDate.isAfter(DateTime.now());
      return true; // Replace with actual validation logic
    } catch (e) {
      return false;
    }
  }
}
