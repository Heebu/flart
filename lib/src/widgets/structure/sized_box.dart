import '../../../flartdart.dart';

typedef SizedBox = FDSizedBox;

class FDSizedBox extends Widget {
  final double? width;
  final double? height;
  final Widget? child;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDSizedBox({
    this.width,
    this.height,
    this.child,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  const FDSizedBox.shrink({
    super.key,
    this.child,
    this.cssStyle,
    this.rawCss,
  })  : width = 0.0,
        height = 0.0;

  const FDSizedBox.expand({
    super.key,
    this.child,
    this.cssStyle,
    this.rawCss,
  })  : width = double.infinity,
        height = double.infinity;

  const FDSizedBox.square({
    super.key,
    double? dimension,
    this.child,
    this.cssStyle,
    this.rawCss,
  })  : width = dimension,
        height = dimension;

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'box-sizing': 'border-box',
    };

    if (width != null) {
      if (width == double.infinity) {
        styles['width'] = '100%';
      } else {
        styles['width'] = '${width}px';
        styles['min-width'] = '${width}px';
      }
    }

    if (height != null) {
      if (height == double.infinity) {
        styles['height'] = '100%';
      } else {
        styles['height'] = '${height}px';
        styles['min-height'] = '${height}px';
      }
    }

    if (child == null) {
      styles['display'] = 'inline-block';
    }

    if (cssStyle != null) styles.addAll(cssStyle!);

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
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
