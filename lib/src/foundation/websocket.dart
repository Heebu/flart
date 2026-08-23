import 'dart:async';
import 'dart:convert';
import 'package:web/web.dart';
import 'dart:js_interop';
import '../../../flartdart.dart';

/// A simpler way to handle WebSockets in Flart.
class FDWebSocket extends ChangeNotifier {
  WebSocket? _socket;
  String? url;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  final _messageController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get onMessage => _messageController.stream;

  FDWebSocket([this.url]);

  void connect([String? connectUrl]) {
    final finalUrl = connectUrl ?? url;
    if (finalUrl == null) {
      print('WebSocket Error: No URL provided');
      return;
    }

    try {
      _socket = WebSocket(finalUrl);

      _socket!.addEventListener(
          'open',
          ((Event _) {
            _isConnected = true;
            notifyListeners();
            print('Connected to WebSocket: $finalUrl');
          }).toJS);

      _socket!.addEventListener(
          'close',
          ((Event _) {
            _isConnected = false;
            notifyListeners();
            print('Disconnected from WebSocket');
          }).toJS);

      _socket!.addEventListener(
          'message',
          ((Event e) {
            final me = e as MessageEvent;
            _messageController.add(me.data);
          }).toJS);

      _socket!.addEventListener(
          'error',
          ((Event e) {
            print('WebSocket Error: $e');
          }).toJS);
    } catch (e) {
      print('Could not connect: $e');
    }
  }

  void send(dynamic data) {
    if (_isConnected && _socket != null) {
      if (data is Map || data is List) {
        _socket!.send(jsonEncode(data).toJS);
      } else if (data is String) {
        _socket!.send(data.toJS);
      } else {
        // Fallback for typed arrays etc.
        _socket!.send(data as JSAny);
      }
    }
  }

  void disconnect() {
    _socket?.close();
    _socket = null;
    _isConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
    super.dispose();
  }
}
