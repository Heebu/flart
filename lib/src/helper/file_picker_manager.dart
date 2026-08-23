import 'package:web/web.dart';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

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

    final script = (document.createElement('script') as HTMLScriptElement)
      ..innerHTML = ('''
        window.__flartHandleFilePick = function(id) {
          if (window.__dartFilePickHandler) {
            window.__dartFilePickHandler(id);
          }
        };
      '''
          .toJS as JSAny);
    document.body?.append(script);

    globalContext.setProperty(
        '__dartFilePickHandler'.toJS,
        ((String id) {
          final input = document.getElementById(id) as HTMLInputElement?;
          if (input != null && input.files != null) {
            final jsFiles = input.files!;
            final files = <File>[];
            for (var i = 0; i < jsFiles.length; i++) {
              files.add(jsFiles.item(i)!);
            }
            _handlers[id]?.call(files);
          }
        }).toJS);
  }
}
