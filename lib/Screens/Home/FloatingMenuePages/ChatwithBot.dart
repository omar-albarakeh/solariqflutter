import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';
import 'package:solariqflutter/Config/AppText.dart';
import '../../../Services/ChatBotService.dart';
import '../../../Widgets/Common/CustomTextField.dart';
import '../../../Widgets/Common/Message/OwnMessage.dart';
import '../../../Widgets/Common/Message/ReplyMessageCard.dart';
import '../../../model/Home/Message.dart';

class ChatWithBot extends StatefulWidget {
  final Map<String, String>? initialMessage;

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
      Future.microtask(() {
        _sendMessage(widget.initialMessage!['message'] ?? '');
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
        color: AppColor.background,
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Messagemodel>>(
                stream: _chatService.messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      (snapshot.data ?? []).isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data ?? [];

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
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
                        _sendMessage(text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(String messageText) async {
    try {
      _chatService.sendMessage(messageText);

      _controller.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $error')),
      );
    }
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
