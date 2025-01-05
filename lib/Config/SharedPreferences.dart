import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'access_token';

  /// Save JWT Token
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      print("Token saved successfully");
    } catch (e) {
      throw Exception('Failed to save token: ${e.toString()}');
    }
  }

  static Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      print("Token retrieved: $token");
      return token;
    } catch (e) {
      throw Exception('Failed to retrieve token: ${e.toString()}');
    }
  }

  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      print("Token deleted successfully");
    } catch (e) {
      throw Exception('Failed to delete token: ${e.toString()}');
    }
  }

  static Future<bool> isTokenValid() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) return false;

      final jwt = JWT.decode(token);
      final expiry = jwt.payload['exp'];
      if (expiry == null) return false;

      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return now < expiry;
    } catch (e) {
      print("Error validating token: ${e.toString()}");
      return false;
    }
  }

  static Future<String?> getUserIdFromToken() async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) return null;

      final jwt = JWT.decode(token);
      final userId = jwt.payload['userId'] ?? jwt.payload['id'];
      print("Extracted User ID: $userId");
      return userId;
    } catch (e) {
      print("Error decoding token: ${e.toString()}");
      return null;
    }
  }
}
