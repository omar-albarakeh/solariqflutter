import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel channel;
  String connectionStatus = "Disconnected";

  void connect(String url, Function(Map<String, dynamic>) onDataReceived) {
    try {
      channel = WebSocketChannel.connect(Uri.parse(url));
      connectionStatus = "Connected";

      channel.stream.listen(
            (data) {
          try {
            final parsedData = jsonDecode(data);
            onDataReceived(parsedData);
          } catch (e) {
            print('Error parsing WebSocket data: $e');
          }
        },
        onDone: () {
          connectionStatus = "Disconnected";
        },
        onError: (error) {
          connectionStatus = "Error: $error";
        },
      );
    } catch (e) {
      connectionStatus = "Error connecting: $e";
    }
  }

  void send(String message) {
    channel.sink.add(message);
  }

  void close() {
    channel.sink.close();
  }
}