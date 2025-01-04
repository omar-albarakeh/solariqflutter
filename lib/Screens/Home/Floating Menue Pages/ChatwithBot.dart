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
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  print('Message sent: ${_controller.text}');
                  _controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}
String _formatTime(String? time) {
  if (time == null || time.isEmpty) return 'Unknown';
  try {
    final parsedTime = DateTime.parse(time);
    return '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
  } catch (e) {
    return 'Invalid';
  }
}