import 'package:flutter/material.dart';
import 'ComunityPost.dart';
import 'api_service.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> posts = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final fetchedPosts = await _apiService.getPosts();
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load posts: $e')),
      );
    }
  }

  Future<void> _toggleLike(dynamic post) async {
    try {
      if (post['hasLiked']) {
        // Remove Like
        await _apiService.unlikePost(post['_id']);
      } else {
        // Add Like
        await _apiService.likePost(post['_id']);
      }

      // Fetch the latest posts to update like counts and statuses
      _fetchPosts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to toggle like: $e')),
      );
    }
  }

  Future<void> _addComment(dynamic post, String text) async {
    try {
      await _apiService.addComment(post['_id'], text);
      // Fetch the latest posts to update comments
      _fetchPosts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add comment: $e')),
      );
    }
  }

  Widget _buildPostCard(dynamic post) {
    final String userName = post['userId']['name'] ?? 'Anonymous';
    final String content = post['text'] ?? 'No content available';
    final int likesCount = post['likes']?.length ?? 0;
    final int commentsCount = post['comments']?.length ?? 0;
    final String type = post['userId']['type'] ?? "user";
    final bool hasLiked = post['hasLiked'] ?? false;

    TextEditingController _commentController = TextEditingController();

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 24, color: Colors.white),
                ),
                const SizedBox(width: 12.0),
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Container(),
                ),
                if (type == 'Engineer')
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Asking engineer...')),
                      );
                    },
                    child: const Text('Ask Engineer', style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),

            const SizedBox(height: 12.0),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await _toggleLike(post);
                      },
                      icon: Icon(
                        hasLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                        color: hasLiked ? Colors.blue : Colors.grey,
                      ),
                    ),
                    Text('$likesCount Likes'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Text('$commentsCount Comments'),
                  ],
                ),
              ],
            ),
            // Add comment section
            const SizedBox(height: 12.0),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                String text = _commentController.text.trim();
                if (text.isNotEmpty) {
                  await _addComment(post, text);
                  _commentController.clear();
                }
              },
              child: const Text('Post Comment'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
          ? const Center(child: Text('Error loading posts'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: posts.length,
        itemBuilder: (context, index) => _buildPostCard(posts[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityPost(onPostCreated: _fetchPosts),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
