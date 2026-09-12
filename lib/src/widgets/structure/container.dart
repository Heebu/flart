import '../../../flartdart.dart';

class FDContainer extends Widget {
  final Widget? child;
  final String? id;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final FlartColor? color;
  final Alignment? alignment;
  final Clip? clipBehavior;
  final Map<String, String>? cssStyle;
  final String? rawCss;
  final VoidCallback? onClick;

  const FDContainer({
    this.child,
    this.id,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.color,
    this.alignment,
    this.clipBehavior,
    this.cssStyle,
    this.rawCss,
    this.onClick,
    super.key,
  }) : assert(
          color == null || decoration == null,
          'Cannot provide both a color and a decoration\n'
          'To provide both, use "decoration: BoxDecoration(color: color)".',
        );

  @override
  FlartNode buildNode(BuildContext context) {
    final effectiveDecoration = decoration ?? (color != null ? BoxDecoration(color: color) : null);

    final styleMap = <String, String>{
      if (width != null)
        'width': width == double.infinity ? '100%' : '${width}px',
      if (height != null)
        'height': height == double.infinity ? '100%' : '${height}px',
      if (padding != null) 'padding': padding!.toCss(),
      if (margin != null) 'margin': margin!.toCss(),
      if (clipBehavior != null && clipBehavior != Clip.none) 'overflow': 'hidden',
      if (onClick != null) 'cursor': 'pointer',
      ...?effectiveDecoration?.toCss(),
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

    final events = <String, void Function(dynamic)>{};
    if (onClick != null) {
      events['click'] = (e) => onClick!();
    }

    return FlartElementNode(
      'div',
      id: id ?? key?.toString(),
      styles: styleMap,
      events: events.isNotEmpty ? events : null,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
