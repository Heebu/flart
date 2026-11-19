import 'package:flartdart/flartdart.dart';

class TextSpan {
  final String? text;
  final TextStyle? style;
  final List<TextSpan>? children;
  final VoidCallback? onTap;
  final String? semanticsLabel;

  const TextSpan({
    this.text,
    this.style,
    this.children,
    this.onTap,
    this.semanticsLabel,
  });

  String render() {
    final styleMap = {
      ...(style?.toCss() ?? {}),
      if (onTap != null) 'cursor': 'pointer',
    };
    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();
    buffer.write('<span style="$styleString">${text ?? ""}</span>');

    if (children != null && children!.isNotEmpty) {
      for (final child in children!) {
        buffer.write(child.render());
      }
    }

    return buffer.toString();
  }
}
