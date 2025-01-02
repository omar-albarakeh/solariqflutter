
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
      username: username,
      email: email,
      password: password,
      type: type,
      phoneNumber: phoneNumber,
      address: address,
    );

    return await _authService.signup(user);
  }

  Future<Map<String, dynamic>> loginController({
    required String email,
    required String password,
  }) async {
    return await _authService.login(
      email: email,
      password: password,
    );
  }

  Future<Map<String, dynamic>> getUserInfoController(String accessToken) async {
    return await _authService.getUserInfo(accessToken);
  }
}