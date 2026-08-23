import '../../../flartdart.dart';

class FDCenter extends Widget {
  final Widget child;
  final String? rawCss;

  const FDCenter({
    required this.child,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': '100%',
      'height': '100%',
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
