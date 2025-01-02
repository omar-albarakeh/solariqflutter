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
      'address': user.address,
    });
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    return HttpHelper.postRequest(url, {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final url = Uri.parse('$_baseUrl/auth/user');
    final headers = {'Authorization': 'Bearer $accessToken'};
    return HttpHelper.getRequest(url, headers: headers);
  }
}