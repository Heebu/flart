import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef ImagePickCallback = void Function(List<web.File> files);

class FDImagePicker extends Widget {
  final bool multiple;
  final ImagePickCallback onImageSelected;
  final Map<String, String>? cssStyle;
  final String buttonLabel;
  final String? rawCss;

  const FDImagePicker({
    required this.onImageSelected,
    this.multiple = false,
    this.cssStyle,
    this.buttonLabel = 'Pick Image',
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final inputId = 'file_input_${key?.toString() ?? hashCode}';

    final buttonStyles = <String, String>{
      'padding': '10px 20px',
      'background-color': '#4caf50',
      'color': '#ffffff',
      'border-radius': '4px',
      'border': 'none',
      'cursor': 'pointer',
      'font-size': '14px',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          buttonStyles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final inputEvents = <String, void Function(web.Event)>{
      'change': (web.Event e) {
        final target = e.target as web.HTMLInputElement?;
        if (target != null && target.files != null) {
          final fileList = <web.File>[];
          final files = target.files!;
          for (var i = 0; i < files.length; i++) {
            final f = files.item(i);
            if (f != null) fileList.add(f);
          }
          if (fileList.isNotEmpty) {
            onImageSelected(fileList);
          }
        }
      },
    };

    final buttonEvents = <String, void Function(dynamic)>{
      'click': (e) {
        final inputEl = web.document.getElementById(inputId) as web.HTMLInputElement?;
        inputEl?.click();
      },
    };

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: {'display': 'inline-block'},
      children: [
        FlartElementNode(
          'input',
          id: inputId,
          attributes: {
            'type': 'file',
            'accept': 'image/*',
            if (multiple) 'multiple': 'true',
          },
          styles: {'display': 'none'},
          events: inputEvents,
        ),
        FlartElementNode(
          'button',
          attributes: {'type': 'button', 'class': 'flart-image-picker-button'},
          styles: buttonStyles,
          events: buttonEvents,
          children: [FlartTextNode(buttonLabel)],
        ),
      ],
    );
  }
}
