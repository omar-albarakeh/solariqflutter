import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomValuesScreen(),
    );
  }
}

class RandomValuesScreen extends StatefulWidget {
  @override
  _RandomValuesScreenState createState() => _RandomValuesScreenState();
}

class _RandomValuesScreenState extends State<RandomValuesScreen> {
  String _values = "Fetching values...";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start fetching data periodically when the screen loads
    _startFetchingData();
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _startFetchingData() {
    // Fetch data every 2 seconds
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await fetchValues();
    });
  }

  Future<void> fetchValues() async {
    try {
      final response = await http.get(Uri.parse("192.168.43.60/getValues"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _values =
          "Value 1: ${data['value1']}, Value 2: ${data['value2']}, Value 3: ${data['value3']}";
        });
      } else {
        setState(() {
          _values = "Error: ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _values = "Failed to connect: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESP8266 Continuous Updates"),
      ),
      body: Center(
        child: Text(
          _values,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
