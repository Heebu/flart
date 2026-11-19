import '../../../flartdart.dart';

typedef Center = FDCenter;

/// A widget that centers its child within itself.
class FDCenter extends Widget {
  final Widget child;
  final double? widthFactor;
  final double? heightFactor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDCenter({
    required this.child,
    this.widthFactor,
    this.heightFactor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'box-sizing': 'border-box',
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      if (widthFactor != null)
        'width': '${widthFactor! * 100}%'
      else
        'width': '100%',
      if (heightFactor != null)
        'height': '${heightFactor! * 100}%'
      else
        'height': '100%',
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
      styles: styleMap,
      children: [child.buildNode(context)],
    );
  }
}
