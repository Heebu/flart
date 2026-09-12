import '../../../flartdart.dart';

class FDStack extends Widget {
  final List<Widget> children;
  final Alignment alignment;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDStack({
    required this.children,
    this.alignment = Alignment.topLeft,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'position': 'relative',
      'width': '100%',
      'height': '100%',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: children.map((child) => child.buildNode(context)).toList(),
    );
  }
}
