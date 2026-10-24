import '../../../flartdart.dart';

class FDDrawer extends Widget {
  final Widget child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDrawer({
    required this.child,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'width': '250px',
      'height': '100%',
      'background-color': 'white',
      'overflow-y': 'auto',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styleMap[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      key: key?.toString(),
      styles: styleMap,
      children: [child.buildNode(context)],
    );
  }

  @override
  String render(BuildContext context) {
    return buildNode(context).toHtml();
  }
}
