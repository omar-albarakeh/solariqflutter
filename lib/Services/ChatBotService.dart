import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../model/Home/Message.dart';

class ChatService {
  final List<Messagemodel> _messages = [
    Messagemodel(
      type: 'target',
      message: "Hello, I am Sara. How can I help you with solar energy systems?",
      time: DateTime.now().toIso8601String(),
    ),
  ];

  final BehaviorSubject<List<Messagemodel>> _messageController = BehaviorSubject.seeded([]);

  List<Map<String, dynamic>> _chatHistory = [];
  String _defaultPrompt = "I am Sara, an expert in solar energy systems. Please ask me questions about solar panels, inverters, batteries, or any aspect of solar energy production.";

  Stream<List<Messagemodel>> get messagesStream => _messageController.stream;

  ChatService() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messageController.add(List.unmodifiable(_messages));
    });
  }

  void _addMessage(Messagemodel message) {
    _messages.add(message);
    _messageController.add(List.unmodifiable(_messages));
  }

  void sendMessage(String userMessage, {String? customPrompt}) {
    if (userMessage.isEmpty) return;

    _addMessage(Messagemodel(
      type: 'source',
      message: userMessage,
      time: DateTime.now().toIso8601String(),
    ));

    if (_isSolarEnergyRelated(userMessage)) {
      generateResponse(userMessage, customPrompt: customPrompt);
    } else {
      _addMessage(Messagemodel(
        type: 'target',
        message: "I'm sorry, I only answer questions related to solar energy systems. Please ask something relevant to solar energy production, panels, inverters, or batteries.",
        time: DateTime.now().toIso8601String(),
      ));
    }
  }

  bool _isSolarEnergyRelated(String userMessage) {
    final relevantTerms = [
      "solar energy", "solar power", "solar panel", "photovoltaic", "solar cells", "renewable energy",
      "solar installation", "solar technology", "solar electricity", "solar farm", "solar inverter",
      "solar battery", "solar grid", "solar systems", "solar maintenance", "solar energy efficiency",
      "solar energy production", "solar storage", "solar batteries", "solar array", "solar installation costs",
      "solar system optimization", "solar output", "solar power generation", "solar technology advancements"
    ];

    return relevantTerms.any((term) => userMessage.toLowerCase().contains(term));
  }

  Future<void> generateResponse(String userMessage, {String? customPrompt}) async {
    final url = Uri.parse('https://chatgem.onrender.com/generatethetext');
    final prompt = customPrompt?.trim().isNotEmpty == true ? customPrompt! : _defaultPrompt;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'history': _chatHistory,
          'userInput': userMessage,
          'prompt': prompt,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['generatedText'] != null) {
          _addMessage(Messagemodel(
            type: 'target',
            message: responseData['generatedText'],
            time: DateTime.now().toIso8601String(),
          ));

          if (responseData['updatedHistory'] != null) {
            _chatHistory = List<Map<String, dynamic>>.from(responseData['updatedHistory']);
          }
        } else {
          _addMessage(Messagemodel(
            type: 'error',
            message: 'Received an empty response from the server.',
            time: DateTime.now().toIso8601String(),
          ));
        }
      } else {
        _addMessage(Messagemodel(
          type: 'error',
          message: 'Error ${response.statusCode}: ${response.body}',
          time: DateTime.now().toIso8601String(),
        ));
      }
    } catch (e) {
      _addMessage(Messagemodel(
        type: 'error',
        message: 'Failed to connect: $e',
        time: DateTime.now().toIso8601String(),
      ));
      debugPrint('Error: $e');
    }
  }

  void setDefaultPrompt(String prompt) {
    _defaultPrompt = prompt;
  }

  void dispose() {
    _messageController.close();
  }
}
