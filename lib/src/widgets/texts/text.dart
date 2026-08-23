import '../../../flartdart.dart';

class FDText extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;
  final String? rawCss;
  final TextTag? tag;
  final TextAlign? textAlign;
  final bool selectable;

  const FDText(
    this.content, {
    this.style,
    this.cssStyle,
    this.rawCss,
    this.tag = TextTag.span,
    this.textAlign,
    this.selectable = false,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final themeStyle = Theme.of(context).textStyle;

    final combinedStyle = {
      ...themeStyle.toCss(),
      ...(style?.toCss() ?? {}),
      if (!selectable) 'user-select': 'none',
      ...(cssStyle ?? {}),
    };

    if (textAlign != null) {
      combinedStyle['text-align'] = textAlign.toString().split('.').last;
    }

    // Include rawCss via a hack or parse it?
    // We don't have a full CSS parser in FlartNode styles yet, 
    // so we can merge it if needed, but usually rawCss isn't used if we have VDOM.
    // For now, if rawCss is provided, we can just apply it via string, but FlartNode takes a map.
    if (rawCss != null && rawCss!.isNotEmpty) {
      // Basic inline style parser for rawCss
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          combinedStyle[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final tagName = tag.toString().split('.').last;

    return FlartElementNode(
      tagName,
      styles: combinedStyle,
      children: [FlartTextNode(content)],
    );
  }
}
