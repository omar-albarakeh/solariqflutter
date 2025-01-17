import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../Config/SharedPreferences.dart';

class ApiService {
  final String _baseUrl = "http://192.168.0.102:3001";

  Future<Map<String, String>> _getHeaders() async {
    final token = await TokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> _handleRequest(Future<http.Response> request) async {
    try {
      final response = await request;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }

  Future<void> createPost(String text) async {
    final url = '$_baseUrl/community/post';
    final headers = await _getHeaders();
    await _handleRequest(
      http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode({'text': text}),
      ),
    );
  }

  Future<void> likePost(String postId) async {
    final url = '$_baseUrl/community/like/$postId';
    final headers = await _getHeaders();
    await _handleRequest(
      http.post(
        Uri.parse(url),
        headers: headers,
      ),
    );
  }

  Future<void> unlikePost(String postId) async {
    final url = '$_baseUrl/community/unlike/$postId'; // Assuming your API uses this route for unliking
    final headers = await _getHeaders();
    await _handleRequest(
      http.delete(  // Using DELETE for removing a like
        Uri.parse(url),
        headers: headers,
      ),
    );
  }

  Future<List<dynamic>> getPosts() async {
    final url = '$_baseUrl/community/posts';
    final headers = await _getHeaders();
    final response = await _handleRequest(
      http.get(Uri.parse(url), headers: headers),
    );

    List<dynamic> posts = response as List<dynamic>;

    posts.sort((a, b) {
      DateTime dateA = DateTime.parse(a['createdAt']);
      DateTime dateB = DateTime.parse(b['createdAt']);
      return dateB.compareTo(dateA);
    });

    return posts;
  }

  Future<void> addComment(String postId, String text) async {
    final url = '$_baseUrl/community/comment/$postId';
    final headers = await _getHeaders();
    await _handleRequest(
      http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode({'text': text}),
      ),
    );
  }


}
