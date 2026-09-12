import '../../../flartdart.dart';

/// A widget that displays its children in multiple horizontal or vertical runs
class FDWrap extends Widget {
  final List<Widget> children;
  final Axis direction;
  final MainAxisAlignment alignment;
  final double spacing;
  final double runSpacing;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDWrap({
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = MainAxisAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final justify = _mapAlignment(alignment);

    final styles = <String, String>{
      'display': 'flex',
      'flex-wrap': 'wrap',
      'flex-direction': direction == Axis.horizontal ? 'row' : 'column',
      'justify-content': justify,
      'gap': '${runSpacing}px ${spacing}px',
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
      attributes: {'class': 'flart-wrap'},
      styles: styles,
      children: children.map((c) => c.buildNode(context)).toList(),
    );
  }

  String _mapAlignment(MainAxisAlignment align) {
    switch (align) {
      case MainAxisAlignment.start:
        return 'flex-start';
      case MainAxisAlignment.end:
        return 'flex-end';
      case MainAxisAlignment.center:
        return 'center';
      case MainAxisAlignment.spaceBetween:
        return 'space-between';
      case MainAxisAlignment.spaceAround:
        return 'space-around';
      case MainAxisAlignment.spaceEvenly:
        return 'space-evenly';
    }
  }
}
