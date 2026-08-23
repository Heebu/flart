import '../../../flartdart.dart';

/// A widget that insets its child by the given padding.
class FDPadding extends Widget {
  final EdgeInsets padding;
  final Widget child;
  final String? rawCss;

  const FDPadding({
    required this.padding,
    required this.child,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'padding': padding.toCss(),
      'box-sizing': 'border-box',
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
      children: [child.buildNode(context)],
    );
  }
}
