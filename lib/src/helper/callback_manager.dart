import 'dart:html';
import 'dart:js';

class FlartCallbackManager {
  static final _handlers = <String, void Function()>{};
  static final _eventHandlers = <String, void Function(dynamic)>{};
  static int _counter = 0;

  static String register(void Function() callback) {
    final id = 'flart_cb_${_counter++}';
    _handlers[id] = callback;

    if (!_jsInjected) _injectGlobalHandler();
    return id;
  }

  static String registerEvent(void Function(dynamic) callback) {
    final id = 'flart_ev_${_counter++}';
    _eventHandlers[id] = callback;

    if (!_jsInjected) _injectGlobalHandler();
    return id;
  }

  static bool _jsInjected = false;

  static void _injectGlobalHandler() {
    _jsInjected = true;

    // Inject JS functions
    final script = ScriptElement()
      ..innerHtml = '''
        window.__flartHandleClick = function(id) {
          if (window.__dartHandleClick) {
            window.__dartHandleClick(id);
          }
        };
        window.__flartHandleEvent = function(id, value) {
          if (window.__dartHandleEvent) {
            window.__dartHandleEvent(id, value);
          }
        };
      ''';
    document.body?.append(script);

    // Wire up Dart handlers
    context['__dartHandleClick'] = allowInterop((String id) {
      final handler = _handlers[id];
      if (handler != null) handler();
    });

    context['__dartHandleEvent'] = allowInterop((String id, dynamic value) {
      final handler = _eventHandlers[id];
      if (handler != null) handler(value);
    });
  }
}
