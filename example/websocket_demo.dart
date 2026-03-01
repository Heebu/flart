import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const WebSocketDemo());
}

class WebSocketViewModel extends ViewModel {
  final FDWebSocket _socket = FDWebSocket();
  final List<String> _messages = [];
  bool _isConnected = false;

  List<String> get messages => _messages;
  bool get isConnected => _isConnected;

  WebSocketViewModel() {
    _socket.onMessage.listen((message) {
      _messages.add('Server: $message');
      notifyListeners();
    });
  }

  void connect() {
    // Using a public echo server for demonstration
    _socket.connect('wss://echo.websocket.org');
    _isConnected = true;
    _messages.add('Connecting...');
    notifyListeners();
  }

  void disconnect() {
    _socket.disconnect();
    _isConnected = false;
    _messages.add('Disconnected.');
    notifyListeners();
  }

  void sendMessage(String text) {
    if (_isConnected) {
      _socket.send(text);
      _messages.add('Me: $text');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }
}

class WebSocketDemo extends StatelessWidget {
  const WebSocketDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart WebSocket 🌐',
      theme: ThemeData.light(),
      home: FDViewModelBuilder<WebSocketViewModel>(
        viewModelBuilder: () => WebSocketViewModel(),
        builder: (context, model, child) => FDScaffold(
          appBar: FDAppBar(
            title: const FDText('WebSocket Echo Demo'),
            backgroundColor: FlartColors.blue,
          ),
          body: FDPadding(
            padding: const EdgeInsets.all(20),
            child: FDColumn(
              children: [
                FDContainer(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: model.isConnected
                        ? FlartColors.green.withOpacity(0.1)
                        : FlartColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FDRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FDText(
                        model.isConnected ? 'Connected' : 'Disconnected',
                        style: TextStyle(
                          color: model.isConnected
                              ? FlartColors.green
                              : FlartColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FDTextButton(
                        onPressed: model.isConnected
                            ? model.disconnect
                            : model.connect,
                        label: model.isConnected ? 'Disconnect' : 'Connect',
                      ),
                    ],
                  ),
                ),
                const FDSizedBox(height: 20),
                FDExpanded(
                  child: FDContainer(
                    decoration: BoxDecoration(
                      border: Border.all(color: FlartColors.grey[100]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FDListView(
                      children: model.messages
                          .map((m) => FDPadding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: FDText(m),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const FDSizedBox(height: 20),
                FDRow(
                  children: [
                    FDExpanded(
                      child: FDContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: FlartColors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const FDPadding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: FDText('Type a message to echo...'),
                        ),
                      ),
                    ),
                    const FDSizedBox(width: 10),
                    FDGestureDetector(
                      onTap: () => model.sendMessage('Hello Flart!'),
                      child: FDContainer(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: FlartColors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const FDIcon(
                            icon: FDIcons.send, color: FlartColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
