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
  String render(BuildContext context) {
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

    final styleString =
        combinedStyle.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    final tagName = tag.toString().split('.').last;

    return '<$tagName style="$styleString ${rawCss ?? ''}">$content</$tagName>';
  }
}
