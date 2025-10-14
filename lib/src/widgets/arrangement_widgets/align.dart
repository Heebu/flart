import 'package:flart_project/flart.dart';

class Align extends Widget {
  final Widget child;
  final Aligns alignment;
  final Map<String, String>? cssStyle;

  Align({
    required this.child,
    this.alignment = Aligns.center,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final alignStyle = alignment.toCss();
    final combinedStyle = {
      ...alignStyle,
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$combinedStyle">${child.render(context)}</div>';
  }
}
