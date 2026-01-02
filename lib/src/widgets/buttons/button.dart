import 'dart:async';
import 'dart:html';

import 'package:flart/flart.dart';

class Button extends Widget {
  final String? text;
  final String? label;
  final Widget? child;
  final void Function()? onPressed;
  final void Function()? onClick; // alias
  final void Function()? onLongPress;
  final Map<String, String>? cssStyle;

  Button({
    this.text,
    this.label,
    this.child,
    this.onPressed,
    this.onClick,
    this.onLongPress,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final id = 'btn-${DateTime.now().microsecondsSinceEpoch}';
    final styles = _styleToString(cssStyle);

    Future.delayed(Duration.zero, () {
      final el = document.querySelector('#$id');
      if (el != null) {
        final tapHandler = onPressed ?? onClick;
        if (tapHandler != null) {
          el.onClick.listen((_) => tapHandler());
        }
        if (onLongPress != null) {
          Timer? longPressTimer;

          el.onMouseDown.listen((_) {
            longPressTimer = Timer(Duration(milliseconds: 600), () {
              onLongPress!();
            });
          });

          el.onMouseUp.listen((_) {
            longPressTimer?.cancel();
          });

          el.onMouseLeave.listen((_) {
            longPressTimer?.cancel();
          });
        }
      }
    });

    final content = child?.render(context) ?? (text ?? label ?? 'Button');

    return '<button id="$id" style="$styles">$content</button>';
  }

  String _styleToString(Map<String, String>? styles) {
    if (styles == null) return '';
    return styles.entries.map((e) => '${e.key}:${e.value}').join(';');
  }
}
