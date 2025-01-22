import '../Config/SharedPreferences.dart';
import '../model/Auth/Users.dart';
import '../utils/helpers.dart';
import 'TokenDecode.dart';

class AuthService {
  final String _baseUrl = "http://192.168.0.102:3001";

  Future<Map<String, dynamic>> signup(Users user) async {
    final url = Uri.parse('$_baseUrl/auth/signup');
    try {
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
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
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

      if (response['status'] == 'success') {
        final token = response['data']['accessToken'];
        await TokenStorage.saveToken(token);
        return response['data'];
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception('No token found');

    final url = Uri.parse('$_baseUrl/auth/user-info');
    try {
      final response = await HttpHelper.getRequest(
        url,
        headers: _buildAuthHeaders(token),
      );

      if (response['status'] == 'success') {
        return response['data'];
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to fetch user info: $e');
    }
  }

  Future<Map<String, dynamic>> submitSolarInfo(
      Map<String, dynamic> formData) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception('No token found');

    final url = Uri.parse('$_baseUrl/auth/update-solar-info');
    try {
      final response = await HttpHelper.postRequest(
        url,
        formData,
        headers: _buildAuthHeaders(token),
      );

      if (response['status'] == 'success') {
        return response;
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to submit solar info: $e');
    }
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required Map<String, dynamic> updatedData,
  }) async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception('No token found');

    // Get the id from the token
    final userId = JwtUtils.getUserIdFromToken(token);
    if (userId == null) throw Exception('User ID not found in token');

    final url = Uri.parse('$_baseUrl/User/updateprofile/$userId');
    try {
      final response = await HttpHelper.putRequest(
        url,
        updatedData,
        headers: _buildAuthHeaders(token),
      );

      if (response['status'] == 'success') {
        return response['data'];
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
  }

  Map<String, String> _buildAuthHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
  Future<Map<String, dynamic>> getUserById() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception('No token found');

    final userId = JwtUtils.getUserIdFromToken(token);
    if (userId == null) throw Exception('User ID not found in token');

    final url = Uri.parse('$_baseUrl/User/$userId');
    try {
      final response = await HttpHelper.getRequest(
        url,
        headers: _buildAuthHeaders(token),
      );

      if (response['status'] == 'success') {
        return response['data'];
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to fetch user by ID: $e');
    }
  }

  Future<String?> getUserIdFromToken() async {
    final token = await TokenStorage.getToken();
    if (token == null) throw Exception('No token found');

    return JwtUtils.getUserIdFromToken(token);
  }

}