import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  final Map<String, dynamic> contact;

  const Chatscreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.contact['profilePicture'] != null
                  ? NetworkImage(widget.contact['profilePicture'])
                  : null,
              child: widget.contact['profilePicture'] == null
                  ? Text(widget.contact['name'][0])
                  : null,
            ),
            const SizedBox(width: 10),
            Text(widget.contact['name']),
          ],
        ),
      ),
      body: Center(
        child: Text("Chat with ${widget.contact['name']}"),
      ),
    );
  }
}