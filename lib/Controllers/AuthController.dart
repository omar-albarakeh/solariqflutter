import '../Services/AuthServices.dart';
import '../model/Auth/Users.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Map<String, dynamic> _buildResponse({
    required String status,
    required String message,
    Map<String, dynamic>? data,
  }) {
    return {
      'status': status,
      'message': message,
      if (data != null) 'data': data,
    };
  }

  Future<Map<String, dynamic>> signupController({
    required String username,
    required String email,
    required String password,
    required String type,
    required String phoneNumber,
    String? address,
  }) async {
    try {
      final response = await _authService.signup(Users(
        name: username,
        email: email,
        password: password,
        type: type,
        phoneNumber: phoneNumber,
        address: address,
      ));
      return _buildResponse(
        status: 'success',
        message: 'User signed up successfully',
        data: response,
      );
    } catch (e) {
      return _buildResponse(
        status: 'error',
        message: 'Signup failed: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> loginController({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.login(email: email, password: password);
      return _buildResponse(
        status: 'success',
        message: 'Login successful',
        data: response,
      );
    } catch (e) {
      return _buildResponse(
        status: 'error',
        message: 'Login failed: ${e.toString()}',
      );
    }
  }

  Future<Map<String, dynamic>> getUserInfoController() async {
    try {
      final response = await _authService.getUserInfo();
      return _buildResponse(
        status: 'success',
        message: 'User info retrieved successfully',
        data: response,
      );
    } catch (e) {
      return _buildResponse(
        status: 'error',
        message: 'Failed to retrieve user info: ${e.toString()}',
      );
    }
  }

  Future<void> logoutController() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> submitSolarInfo(Map<String, dynamic> formData) async {
    try {
      final response = await _authService.submitSolarInfo(formData);
      return _buildResponse(
        status: 'success',
        message: 'Solar information submitted successfully',
        data: response,
      );
    } catch (e) {
      return _buildResponse(
        status: 'error',
        message: 'Failed to submit solar info: ${e.toString()}',
      );
    }
  }
}
