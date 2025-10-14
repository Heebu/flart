import 'package:flart_project/src/widgets/utils/build_context.dart';

import '../widget.dart';
import 'text_span.dart';

class RichText extends Widget {
  final TextSpan textSpan;
  final Map<String, String>? cssStyle;

  RichText({
    required this.textSpan,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleString = (cssStyle ?? {}).entries
        .map((e) => '${e.key}: ${e.value};')
        .join(' ');

    return '<div style="$styleString">${textSpan.render()}</div>';
  }


}


//RichText(
//   textSpan: TextSpan(
//     text: "Hello ",
//     style: TextStyle(color: FlartColor('#000')),
//     children: [
//       TextSpan(
//         text: "world",
//         style: TextStyle(color: FlartColor('#ff0000'), fontWeight: FontWeight.bold),
//       ),
//       TextSpan(
//         text: "!",
//       ),
//     ],
//   ),
// )