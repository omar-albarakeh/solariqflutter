import 'package:flutter/material.dart';
import 'CommentsPage.dart';
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

  // Fetch all posts
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

  // Toggle like/unlike for the post
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

  // Navigate to comments page
  Future<void> _viewComments(dynamic post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsPage(postId: post['_id']),
      ),
    );
    _fetchPosts();  // Refresh posts after returning from comments page
  }

  // Build the UI for each post card
  Widget _buildPostCard(dynamic post) {
    final String userName = post['userId']['name'] ?? 'Anonymous';
    final String content = post['text'] ?? 'No content available';
    final int likesCount = post['likes']?.length ?? 0;
    final int commentsCount = post['comments']?.length ?? 0;
    final bool hasLiked = post['hasLiked'] ?? false;

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
                    IconButton(
                      onPressed: () async {
                        await _viewComments(post);
                      },
                      icon: const Icon(Icons.comment, color: Colors.grey),
                    ),
                    Text('$commentsCount Comments'),
                  ],
                ),
              ],
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
