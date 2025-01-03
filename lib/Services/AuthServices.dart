import '../Config/SharedPreferences.dart';
import '../model/Auth/Users.dart';
import '../utils/helpers.dart';

class AuthService {
  final String _baseUrl = "http://192.168.0.103:3001";

  Future<Map<String, dynamic>> signup(Users user) async {
    final url = Uri.parse('$_baseUrl/auth/signup');
    final response = await HttpHelper.postRequest(url, {
      'email': user.email,
      'password': user.password,
      'name': user.name,
      'type': user.type,
      'phone': user.phoneNumber,
      'address': user.address ?? '',
    });

    if (response['status'] == 'success') {
      return response['data'];
    } else {
      throw Exception(response['message']);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await HttpHelper.postRequest(url, {
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      final token = response['data']['accessToken'];
      await TokenStorage.saveToken(token);
      return response['data'];
    } else {
      throw Exception(response['message']);
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    final url = Uri.parse('$_baseUrl/auth/user-info');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await HttpHelper.getRequest(url, headers: headers);

    if (response.containsKey('status') && response['status'] == 'success' && response.containsKey('data')) {
      return {
        'status': response['status'],
        'data': response['data'], // Ensure the `data` field exists and is passed correctly
      };
    } else if (response.containsKey('message')) {
      throw Exception(response['message']);
    } else {
      throw Exception('Unexpected response structure');
    }
  }


  Future<void> logout() async {
    await TokenStorage.deleteToken();
  }
}
