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


}
