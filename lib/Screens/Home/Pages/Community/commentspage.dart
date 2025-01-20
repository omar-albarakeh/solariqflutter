import 'package:flutter/material.dart';
import 'api_service.dart';

class CommentsPage extends StatefulWidget {
  final String postId;

  const CommentsPage({super.key, required this.postId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> comments = [];
  bool isLoading = true;
  bool hasError = false;
  final TextEditingController _commentController = TextEditingController();
  bool _isAddingComment = false;  // Define the _isAddingComment variable

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  // Fetch the comments for a specific post
  Future<void> _fetchComments() async {
    try {
      final post = await _apiService.getPost(widget.postId);
      setState(() {
        comments = post['comments'] ?? [];
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load comments: $e')),
      );
    }
  }

  // Add a new comment to the post
  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    setState(() => _isAddingComment = true);  // Set _isAddingComment to true while adding

    try {
      String text = _commentController.text.trim();
      await _apiService.addComment(widget.postId, text);
      _commentController.clear();
      _fetchComments();  // Refresh comments after adding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add comment: $e')),
      );
    } finally {
      setState(() => _isAddingComment = false);  // Set _isAddingComment back to false after adding
    }
  }

  // Build the UI for each comment in the list
  Widget _buildCommentCard(dynamic comment) {
    return ListTile(
      title: Text(comment['text'] ?? 'No text'),
      subtitle: Text(comment['userId']['name'] ?? 'Anonymous'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
          ? const Center(child: Text('Error loading comments'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return _buildCommentCard(comment);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isAddingComment ? null : _addComment,  // Disable while adding
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
