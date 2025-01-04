import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Config/AppText.dart';

import '../../../Widgets/Common/CustomTextField.dart';

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
      body:  _buildInputArea(),
    );
  }
}
Widget _buildInputArea() {
  final TextEditingController _controller = TextEditingController();

  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              label: 'Type a message...',
              controller: _controller,
              obscureText: false,
              keyboardType: TextInputType.multiline,
              width: double.infinity,
              suffixIcon: null,
            ),
          ),
          
        ],
      ),
    ),
  );
}
