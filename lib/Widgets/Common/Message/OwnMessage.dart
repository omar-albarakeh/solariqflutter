import 'package:flutter/material.dart';

import 'MessageCard.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({
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
      alignment: Alignment.centerRight,
      borderColor: const Color(0xFF6C63FF),
      cardColor: const Color(0xFFE8F0FE),
      textColor: const Color(0xFF003366),
      timeColor: const Color(0xFF5A5A5A), 
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(19),
        bottomLeft: Radius.circular(19),
        bottomRight: Radius.circular(19),
      ),
    );
  }
}