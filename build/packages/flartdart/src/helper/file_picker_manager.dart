import 'dart:html';
import 'dart:js';

typedef FilePickHandler = void Function(List<File> files);

class FlartFilePickerManager {
  static final _handlers = <String, FilePickHandler>{};
  static int _counter = 0;
  static bool _injected = false;

  static String register(FilePickHandler handler) {
    final id = 'file_picker_${_counter++}';
    _handlers[id] = handler;

    if (!_injected) _injectJsBridge();
    return id;
  }

  static void _injectJsBridge() {
    _injected = true;

    final script = ScriptElement()
      ..innerHtml = '''
        window.__flartHandleFilePick = function(id) {
          if (window.__dartFilePickHandler) {
            window.__dartFilePickHandler(id);
          }
        };
      ''';
    document.body?.append(script);

    context['__dartFilePickHandler'] = allowInterop((String id) {
      final input = document.getElementById(id) as FileUploadInputElement?;
      if (input != null && input.files != null) {
        final files = input.files!;
        _handlers[id]?.call(files);
      }
    });
  }
}
