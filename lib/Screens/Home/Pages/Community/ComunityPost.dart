import 'package:flutter/material.dart';
import 'api_service.dart';

class CommunityPost extends StatefulWidget {
  final Future<void> Function() onPostCreated;

  const CommunityPost({super.key, required this.onPostCreated});

  @override
  State<CommunityPost> createState() => _CommunityPostState();
}

class _CommunityPostState extends State<CommunityPost> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();

  void _createPost() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post text cannot be empty')),
      );
      return;
    }

    try {
      await _apiService.createPost(_controller.text);
      widget.onPostCreated();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Write something...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createPost,
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
