import 'dart:convert';

import '../../../Config/SharedPreferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.0.103:3001';

  get http => null;

  Future<List<dynamic>> fetchContacts(String token) async {
    try {
      final token = await TokenStorage.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please login again.');
      }

      final isValid = await TokenStorage.isTokenValid();
      if (!isValid) {
        throw Exception('Token is invalid or expired. Please login again.');
      }


  }
}

