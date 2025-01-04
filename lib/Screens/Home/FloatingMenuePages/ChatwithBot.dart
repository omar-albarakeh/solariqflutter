import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Config/AppText.dart';
import '../../../Services/ChatBotService.dart';
import '../../../Widgets/Common/CustomTextField.dart';
import '../../../Widgets/Common/Message/OwnMessage.dart';
import '../../../Widgets/Common/Message/ReplyMessageCard.dart';
import '../../../model/Message.dart';

class ChatWithBot extends StatefulWidget {
  final String? initialMessage;

  const ChatWithBot({Key? key, this.initialMessage}) : super(key: key);

  @override
  State<ChatWithBot> createState() => _ChatWithBotState();
}

class _ChatWithBotState extends State<ChatWithBot> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatService _chatService;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService();

    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chatService.sendMessage(widget.initialMessage!);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          'SOLARIQ-BOT',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColor.linearGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Messagemodel>>(
                stream: _chatService.messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && (snapshot.data ?? []).isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data ?? [];
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    }
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      if (message.type == "source") {
                        return OwnMessageCard(
                          message: message.message ?? '',
                          time: _formatTime(message.time),
                        );
                      } else {
                        return ReplyMessageCard(
                          message: message.message ?? '',
                          time: _formatTime(message.time),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
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
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    _chatService.sendMessage(text);
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
}
