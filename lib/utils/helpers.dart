import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Map<String, dynamic> _processResponse(http.Response response) {
    try {
      final decodedBody = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedBody;
      } else {
        return {
          'status': 'error',
          'message': decodedBody['message'] ?? 'Unexpected error occurred.',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to process response: ${e.toString()}',
        'statusCode': response.statusCode,
      };
    }
  }

  static Future<Map<String, dynamic>> postRequest(
      Uri url, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        url,
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> getRequest(Uri url,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(url, headers: headers);
      return _processResponse(response);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Network error: ${e.toString()}',
      };
    }
  }
}
