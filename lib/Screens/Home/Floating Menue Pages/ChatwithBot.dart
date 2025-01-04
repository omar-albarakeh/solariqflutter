import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';

class ChatWithBot extends StatefulWidget {
  const ChatWithBot({super.key});

  @override
  State<ChatWithBot> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatWithBot> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'SOLARIQ-BOT',
          style:AppTextStyles.appBarTitle,
        ),
      ),
    );
  }
}
