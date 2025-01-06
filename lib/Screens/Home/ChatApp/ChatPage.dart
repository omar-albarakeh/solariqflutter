import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp" ,style: AppTextStyles.appBarTitle),
        actions: [
          Icon(Icons.search),
        ],
      ),

    );
  }
}
