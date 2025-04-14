import 'package:flart_project/src/styles/align.dart';

import 'widget.dart';

class Align extends Widget {
  final Widget child;
  final align alignment;
  final Map<String, String>? cssStyle;

  Align({
    required this.child,
    this.alignment = align.center,
    this.cssStyle,
  });

  @override
  String render() {
    final alignStyle = alignment.toCss();
    final combinedStyle = {
      ...alignStyle,
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$combinedStyle">${child.render()}</div>';
  }
}
