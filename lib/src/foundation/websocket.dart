import 'dart:async';
import 'dart:convert';
import 'dart:html';
import '../../../flartdart.dart';

/// A simpler way to handle WebSockets in Flart.
class FDWebSocket extends ChangeNotifier {
  WebSocket? _socket;
  final String url;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  final _messageController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get messages => _messageController.stream;

  FDWebSocket(this.url);

  void connect() {
    try {
      _socket = WebSocket(url);

      _socket!.onOpen.listen((_) {
        _isConnected = true;
        notifyListeners();
        print('Connected to WebSocket: $url');
      });

      _socket!.onClose.listen((_) {
        _isConnected = false;
        notifyListeners();
        print('Disconnected from WebSocket');
      });

      _socket!.onMessage.listen((MessageEvent e) {
        _messageController.add(e.data);
      });

      _socket!.onError.listen((e) {
        print('WebSocket Error: $e');
      });
    } catch (e) {
      print('Could not connect: $e');
    }
  }

  void send(dynamic data) {
    if (_isConnected && _socket != null) {
      if (data is Map || data is List) {
        _socket!.sendString(jsonEncode(data));
      } else {
        _socket!.send(data);
      }
    }
  }

  void disconnect() {
    _socket?.close();
    _socket = null;
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
    super.dispose();
  }
}
