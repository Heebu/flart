import 'package:flart_project/src/widgets/utils/build_context.dart';

import '../../../flart.dart';


class SelectableText extends Widget {
  final String content;
  final TextStyle? style;
  final Map<String, String>? cssStyle;

  SelectableText(
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



//SelectableText(
//   'You can copy this text.',
//   style: TextStyle(
//     fontSize: 16,
//     color: FlartColor('#333333'),
//   ),
//   textAlign: TextAlign.center,
// )