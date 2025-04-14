import 'dart:html';

class FlartCallbackManager {
  static final _handlers = <String, void Function()>{};
  static int _counter = 0;

  static String register(void Function() callback) {
    final id = 'flart_cb_${_counter++}';
    _handlers[id] = callback;

    // Inject the JS handler once
    if (!_jsInjected) _injectGlobalHandler();

    return id;
  }

  static bool _jsInjected = false;

  static void _injectGlobalHandler() {
    _jsInjected = true;
    final script = ScriptElement()
      ..innerHtml = '''
        window.__flartHandleClick = function(id) {
          if (window.__dartHandleClick) {
            window.__dartHandleClick(id);
          }
        };
      ''';
    document.body?.append(script);

    // Now expose the Dart-side handler
    context['__dartHandleClick'] = allowInterop((String id) {
      final handler = _handlers[id];
      if (handler != null) handler();
    });
  }
}
