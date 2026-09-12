import '../../../flartdart.dart';

/// A widget that imposes additional constraints on its child.
class FDConstrainedBox extends Widget {
  final BoxConstraints constraints;
  final Widget child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDConstrainedBox({
    required this.constraints,
    required this.child,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      ...constraints.toCssMap(),
      'box-sizing': 'border-box',
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
      children: [child.buildNode(context)],
    );
  }
}

class BoxConstraints {
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  const BoxConstraints({
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  });

  const BoxConstraints.tightFor({
    double? width,
    double? height,
  })  : minWidth = width ?? 0.0,
        maxWidth = width ?? double.infinity,
        minHeight = height ?? 0.0,
        maxHeight = height ?? double.infinity;

  const BoxConstraints.expand({
    double? width,
    double? height,
  })  : minWidth = width ?? double.infinity,
        maxWidth = width ?? double.infinity,
        minHeight = height ?? double.infinity,
        maxHeight = height ?? double.infinity;

  Map<String, String> toCssMap() {
    final style = <String, String>{};
    if (minWidth > 0 && minWidth != double.infinity) style['min-width'] = '${minWidth}px';
    if (minWidth == double.infinity) style['min-width'] = '100%';
    if (maxWidth != double.infinity) style['max-width'] = '${maxWidth}px';
    if (minHeight > 0 && minHeight != double.infinity) style['min-height'] = '${minHeight}px';
    if (minHeight == double.infinity) style['min-height'] = '100%';
    if (maxHeight != double.infinity) style['max-height'] = '${maxHeight}px';
    return style;
  }

  String toCss() {
    return toCssMap().entries.map((e) => '${e.key}: ${e.value}').join('; ');
  }
}
