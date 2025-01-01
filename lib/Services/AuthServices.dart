import '../model/Auth/Users.dart';
import '../utils/helpers.dart';

class AuthService {
  static const String baseUrl = "http://192.168.0.103:3000/user";

  Future<Map<String, dynamic>> signup(Users user) async {
    final Uri url = Uri.parse('$baseUrl/signup');
    try {
      final response = await HttpHelper.postRequest(url, user.toJson());
      return response;
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final Uri url = Uri.parse('$baseUrl/login');
    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };
    try {
      final response = await HttpHelper.postRequest(url, requestBody);
      return response;
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final Uri url = Uri.parse('$baseUrl/me');
    try {
      final response = await HttpHelper.getRequest(url, headers: {
        'Authorization': 'Bearer $accessToken',
      });
      return response;
    } catch (e) {
      return {'error': 'Network error: ${e.toString()}'};
    }
  }
}
