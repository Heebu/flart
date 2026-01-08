import 'package:flartdart/flartdart.dart';

import '../../styles/text_style.dart';

class TextSpan {
  final String text;
  final TextStyle? style;
  final List<TextSpan>? children;

  TextSpan({
    required this.text,
    this.style,
    this.children,
  });

  String render() {
    final styleString = (style?.toCss() ?? {})
        .entries
        .map((e) => '${e.key}: ${e.value};')
        .join(' ');

    final buffer = StringBuffer();
    buffer.write('<span style="$styleString">$FDText</span>');

    if (children != null && children!.isNotEmpty) {
      for (final child in children!) {
        buffer.write(child.render());
      }
    }

    return buffer.toString();
  }
}


//TextSpan(
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



