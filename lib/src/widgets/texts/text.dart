

import '../../../flartdart.dart';

class Text extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;
  final TextTag? tag;
  final TextAlign? textAlign;
  final bool selectable;

  Text(
    this.content, {
    this.style,
    this.cssStyle,
    this.tag = TextTag.span,
    this.textAlign,
    this.selectable = false,
  });

  @override
  String render(BuildContext context) {
    final combinedStyle = {
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

    return '<$tagName style="$styleString">$content</$tagName>';
  }
}



//Text(
//   'Welcome to Flart!',
//   tag: TextTag.h1,
//   textAlign: TextAlign.center,
//   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
// );