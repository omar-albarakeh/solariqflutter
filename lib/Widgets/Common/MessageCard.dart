import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {

  final String message;
  final String time;
  final Alignment alignment;
  final Color borderColor;
  final Color cardColor;
  final Color textColor;
  final Color timeColor;
  final BorderRadius borderRadius;
  
  const MessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.alignment,
    required this.borderColor,
    required this.cardColor,
    required this.textColor,
    required this.timeColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}