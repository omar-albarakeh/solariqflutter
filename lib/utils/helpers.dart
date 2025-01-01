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
}
