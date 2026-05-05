import 'dart:js_interop';
import 'package:web/web.dart' as web;

@JS('__dartHandleClick')
external set _dartClickHandler(JSFunction value);

@JS('__dartHandleEvent')
external set _dartEventHandler(JSFunction value);

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

    // Inject JS bridge functions
    final script = web.HTMLScriptElement()
      ..textContent = '''
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
    web.document.body?.append(script);

    // Wire up Dart handlers via dart:js_interop
    _dartClickHandler = ((JSString id) {
      final handler = _handlers[id.toDart];
      if (handler != null) handler();
    }).toJS;

    _dartEventHandler = ((JSString id, JSAny? value) {
      final handler = _eventHandlers[id.toDart];
      if (handler != null) handler(value?.dartify());
    }).toJS;
  }
}
