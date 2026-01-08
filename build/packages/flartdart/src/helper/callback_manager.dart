import 'dart:html';
import 'dart:js';

class FlartCallbackManager {
  static final _handlers = <String, void Function()>{};
  static int _counter = 0;

  static String register(void Function() callback) {
    final id = 'flart_cb_${_counter++}';
    _handlers[id] = callback;

    if (!_jsInjected) _injectGlobalHandler();
    return id;
  }

  static bool _jsInjected = false;

  static void _injectGlobalHandler() {
    _jsInjected = true;

    // Inject JS function
    final script = ScriptElement()
      ..innerHtml = '''
        window.__flartHandleClick = function(id) {
          if (window.__dartHandleClick) {
            window.__dartHandleClick(id);
          }
        };
      ''';
    document.body?.append(script);

    // Wire up Dart handler
    context['__dartHandleClick'] = allowInterop((String id) {
      final handler = _handlers[id];
      if (handler != null) handler();
    });
  }
}
