import '../../styles/text_style.dart';
import '../widget.dart';

class Text extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;

  Text(this.content, {this.style, this.cssStyle});

  @override
  String render() {
    final styleMap = {
      ...(style?.toCss() ?? {}),
      ...(cssStyle ?? {}),
    };
    final styleString = styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    return '<span style="$styleString">$content</span>';
  }
}
