import '../../../flartdart.dart';

class FDSelectableText extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;

  FDSelectableText(
    this.content, {
    this.style,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleMap = {
      'user-select': 'text',
      ...(style?.toCss() ?? {}),
      ...?cssStyle,
    };
    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');
    return '<span style="$styleString">$content</span>';
  }
}



//FDSelectableText(
//   'You can copy this.text.',
//   style: TextStyle(
//     fontSize: 16,
//     color: FlartColor('#333333'),
//   ),
//   textAlign: TextAlign.center,
// )



