// import 'package:flutter/material.dart';
// import 'api_service.dart';
//
// class CommentsPage extends StatefulWidget {
//   final String postId;
//
//   const CommentsPage({super.key, required this.postId});
//
//   @override
//   _CommentsPageState createState() => _CommentsPageState();
// }
//
// class _CommentsPageState extends State<CommentsPage> {
//   final ApiService _apiService = ApiService();
//   List<dynamic> comments = [];
//   bool isLoading = true;
//   bool hasError = false;
//   final TextEditingController _commentController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComments();
//   }
//
//   Future<void> _fetchComments() async {
//     try {
//       final post = await _apiService.getPost(widget.postId);
//       setState(() {
//         comments = post['comments'] ?? [];
//         isLoading = false;
//         hasError = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         hasError = true;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load comments: $e')),
//       );
//     }
//   }
//
//   Future<void> _addComment() async {
//     try {
//       String text = _commentController.text.trim();
//       if (text.isNotEmpty) {
//         await _apiService.addComment(widget.postId, text);
//         _commentController.clear();
//         _fetchComments();
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add comment: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Comments'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : hasError
//           ? const Center(child: Text('Error loading comments'))
//           : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: comments.length,
//               itemBuilder: (context, index) {
//                 final comment = comments[index];
//                 return ListTile(
//                   title: Text(comment['text'] ?? 'No text'),
//                   subtitle: Text(comment['userId']['name'] ?? 'Anonymous'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(
//                       hintText: 'Add a comment...',
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: 3,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _addComment,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
