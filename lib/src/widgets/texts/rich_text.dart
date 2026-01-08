import '../../../flartdart.dart';

class FDRichText extends Widget {
  final TextSpan textSpan;
  final Map<String, String>? cssStyle;

  FDRichText({
    required this.textSpan,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleString =
        (cssStyle ?? {}).entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString">${textSpan.render()}</div>';
  }
}


//FDRichText(
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



