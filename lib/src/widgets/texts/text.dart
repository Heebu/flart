import '../widget.dart';
import '../utils/build_context.dart';
import '../../styles/text_style.dart';
import '../../styles/theme.dart';
import '../../enums/text_tag.dart';
import '../../enums/text_align.dart';

class FDText extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;
  final String? rawCss;
  final TextTag? tag;
  final TextAlign? textAlign;
  final bool selectable;

  FDText(
    this.content, {
    this.style,
    this.cssStyle,
    this.rawCss,
    this.tag = TextTag.span,
    this.textAlign,
    this.selectable = false,
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



//FDText(
//   'Welcome to Flart!',
//   tag: TextTag.h1,
//   textAlign: TextAlign.center,
//   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
// );



