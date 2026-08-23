import '../../../flartdart.dart';

/// A widget that makes its child scrollable
class FDSingleChildScrollView extends Widget {
  final Widget child;
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDSingleChildScrollView({
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.cssStyle,
    this.rawCss,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final isVertical = scrollDirection == Axis.vertical;
    final styles = <String, String>{
      'overflow-x': isVertical ? 'hidden' : 'auto',
      'overflow-y': isVertical ? 'auto' : 'hidden',
      'display': 'block',
      'width': '100%',
      'height': '100%',
    };

    if (padding != null) {
      styles['padding'] = padding!.toCss();
    }

    if (cssStyle != null) {
      styles.addAll(cssStyle!);
    }

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
      attributes: {'class': 'flart-scroll-view'},
      styles: styles,
      children: [child.buildNode(context)],
    );
  }
}
