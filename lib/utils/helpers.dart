import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return {
        'error': 'Request failed with status: ${response.statusCode}',
        'status': response.statusCode,
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
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

}
