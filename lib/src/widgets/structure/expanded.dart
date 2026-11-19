import '../../../flartdart.dart';

typedef Expanded = FDExpanded;

class FDExpanded extends Widget {
  final Widget child;
  final int flex;
  final String? rawCss;

  const FDExpanded({
    required this.child,
    this.flex = 1,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final styles = <String, String>{
      'box-sizing': 'border-box',
      'flex': '$flex $flex 0px',
      'min-width': '0',
      'min-height': '0',
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
