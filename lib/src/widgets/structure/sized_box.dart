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

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{};
    if (width != null) styles['width'] = '${width}px';
    if (height != null) styles['height'] = '${height}px';
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
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
