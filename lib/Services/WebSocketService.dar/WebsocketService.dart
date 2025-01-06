import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String serverUrl;
  late WebSocketChannel _channel;

  WebSocketService({required this.serverUrl});

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  Stream get messages => _channel.stream;

  void disconnect() {
    _channel.sink.close();
  }
}
