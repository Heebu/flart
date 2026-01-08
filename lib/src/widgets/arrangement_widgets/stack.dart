import '../../../flartdart.dart';

class FDStack extends Widget {
  final List<Widget> children;
  final Map<String, String>? cssStyle;

  FDStack({
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



