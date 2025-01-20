import 'Users.dart';

class AuthResponse {
  final String token;
  final Users user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: Users.fromJson(json['user']),
    );
  }
}