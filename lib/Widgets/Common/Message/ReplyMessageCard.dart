import 'package:flutter/material.dart';

import 'MessageCard.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return MessageCard(
      message: message,
      time: time,
      alignment: Alignment.centerLeft,
      borderColor: const Color(0xFF4CAF50),
      cardColor: const Color(0xFFFFFDE7),
      textColor: const Color(0xFF1B5E20),
      timeColor: const Color(0xFF757575),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(19),
        bottomLeft: Radius.circular(19),
        bottomRight: Radius.circular(19),
      ),
    );
  }
}