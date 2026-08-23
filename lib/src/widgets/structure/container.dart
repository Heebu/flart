import '../../../flartdart.dart';

class FDContainer extends Widget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final Alignment? alignment;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDContainer({
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      if (width != null)
        'width': width == double.infinity ? '100%' : '${width}px',
      if (height != null)
        'height': height == double.infinity ? '100%' : '${height}px',
      if (padding != null) 'padding': padding!.toCss(),
      if (margin != null) 'margin': margin!.toCss(),
      ...?decoration?.toCss(),
      ...?alignment?.toCss(),
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
      styles: styleMap,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
