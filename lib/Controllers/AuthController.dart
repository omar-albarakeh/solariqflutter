import '../Services/AuthServices.dart';
import '../model/Auth/Users.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> signupController({
    required String username,
    required String email,
    required String password,
    required String type,
    required String phoneNumber,
    String? address,
  }) async {
    Users user = Users(
      name: username,
      email: email,
      password: password,
      type: type,
      phoneNumber: phoneNumber,
      address: address,
    );

    try {
      final response = await _authService.signup(user);
      return {
        'status': 'success',
        'message': 'User signed up successfully',
        'data': response,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Signup failed: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> loginController({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.login(email: email, password: password);
      return {
        'status': 'success',
        'message': 'Login successful',
        'data': response,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Login failed: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getUserInfoController(String accessToken) async {
    try {
      final response = await _authService.getUserInfo(accessToken);
      return {
        'status': 'success',
        'message': 'User information retrieved successfully',
        'data': response,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Failed to retrieve user info: ${e.toString()}',
      };
    }
  }
}