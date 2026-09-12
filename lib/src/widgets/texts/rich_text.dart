import '../../../flartdart.dart';

typedef RichText = FDRichText;

class FDRichText extends Widget {
  final TextSpan textSpan;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDRichText({
    TextSpan? textSpan,
    TextSpan? text,
    this.cssStyle,
    this.rawCss,
    super.key,
  }) : textSpan = textSpan ?? text ?? const TextSpan();

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'display': 'inline',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: [_buildSpanNode(textSpan)],
    );
  }

  FlartNode _buildSpanNode(TextSpan span) {
    final spanStyles = <String, String>{};
    if (span.style != null) {
      spanStyles.addAll(span.style!.toCss());
    }

    final children = <FlartNode>[];
    if (span.text != null && span.text!.isNotEmpty) {
      children.add(FlartTextNode(span.text!));
    }
    if (span.children != null) {
      for (final child in span.children!) {
        children.add(_buildSpanNode(child));
      }
    }

    return FlartElementNode(
      'span',
      styles: spanStyles,
      children: children,
    );
  }
}
