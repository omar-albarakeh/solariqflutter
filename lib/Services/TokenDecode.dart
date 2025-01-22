import 'dart:convert';

class JwtUtils {
  static String? getUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid token');
      }

      final payload = parts[1];
      final normalizedPayload = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

      final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;
      
      return payloadMap['id'] as String?;
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }
}