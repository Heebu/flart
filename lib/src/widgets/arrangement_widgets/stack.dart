import 'package:flart_project/flart.dart';

class Stack extends Widget {
  final List<Widget> children;
  final Map<String, String>? cssStyle;

  Stack({
    required this.children,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final style = {
      'position': 'relative',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    final buffer = StringBuffer();
    buffer.writeln('<div style="$style">');
    for (final child in children) {
      buffer.writeln(child.render(context));
    }
    buffer.writeln('</div>');

    return buffer.toString();
  }
}
