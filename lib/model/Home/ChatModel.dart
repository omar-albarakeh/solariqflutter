import 'dart:ui';
import 'package:flutter/material.dart';

class ChatModel {
  final String name;
  final String time;
  final String currentMessage;
  final int id;
  final bool isGroup;
  final Color iconColor;

  ChatModel({
    required this.name,
    required this.time,
    required this.currentMessage,
    required this.id,
    required this.isGroup,
    required this.iconColor,
  });

  IconData getIcon() {
    return isGroup ? Icons.group : Icons.person;
  }
}
