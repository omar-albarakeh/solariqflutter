import '../model/Auth/Users.dart';
import '../utils/helpers.dart';

class AuthService {
  final String _baseUrl = "http://192.168.0.103:3001";

  Future<Map<String, dynamic>> signup(Users user) async {
    final url = Uri.parse('$_baseUrl/auth/signup');
    return HttpHelper.postRequest(url, {
      'email': user.email,
      'password': user.password,
      'name': user.name,
      'type': user.type,
      'phone': user.phoneNumber,
      'address': user.address ?? '',
    });
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await HttpHelper.postRequest(url, {
        'email': email,
        'password': password,
      });
      print("Login Response: $response"); // Debugging line
      return response;
    } catch (e) {
      throw Exception('Login error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String token) async {
    final url = Uri.parse('$_baseUrl/auth/user');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await HttpHelper.getRequest(url, headers: headers);
      if (response['status'] != 'success') {
        throw Exception(response['message'] ?? 'Failed to fetch user info');
      }
      return response;
    } catch (e) {
      throw Exception('Error fetching user info: ${e.toString()}');
    }
  }
}
