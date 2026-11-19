import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef ImagePickCallback = void Function(List<web.File> files);

class FDImagePicker extends Widget {
  final bool multiple;
  final ImagePickCallback onImageSelected;
  final String buttonLabel;
  final FlartColor? buttonColor;
  final FlartColor? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const FDImagePicker({
    required this.onImageSelected,
    this.multiple = false,
    this.buttonLabel = 'Pick Image',
    this.buttonColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final inputId = 'file_input_${key?.toString() ?? hashCode}';
    final bgColor = buttonColor?.toString() ?? theme.primaryColor.toString();
    final fgColor = textColor?.toString() ?? '#ffffff';
    final radius = borderRadius?.topLeft ?? 4.0;
    final pad = padding?.toCss() ?? '10px 20px';

    final buttonStyles = <String, String>{
      'padding': pad,
      'background-color': bgColor,
      'color': fgColor,
      'border-radius': '${radius}px',
      'border': 'none',
      'cursor': 'pointer',
      'font-size': '14px',
      'font-weight': '500',
      'font-family': 'inherit',
      'transition': 'opacity 0.2s',
    };

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
        final inputEl =
            web.document.getElementById(inputId) as web.HTMLInputElement?;
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
