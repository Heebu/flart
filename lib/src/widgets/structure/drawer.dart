import '../../../flartdart.dart';

typedef Drawer = FDDrawer;

class FDDrawer extends Widget {
  final Widget child;
  final double? width;
  final FlartColor? backgroundColor;
  final double elevation;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDDrawer({
    required this.child,
    this.width,
    this.backgroundColor,
    this.elevation = 16.0,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.cardColor;
    final w = width ?? 304.0;

    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'width': '${w}px',
      'height': '100%',
      'background-color': bg.toString(),
      'overflow-y': 'auto',
      'box-shadow': '0 8px 10px -5px rgba(0,0,0,0.2), 0 16px 24px 2px rgba(0,0,0,0.14), 0 6px 30px 5px rgba(0,0,0,0.12)',
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
