import '../../../flartdart.dart';

class FDRow extends Widget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Map<String, String>? cssStyle;
  final String? rawCss;
  const FDRow({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  final double? spacing;

  @override
  FlartNode buildNode(BuildContext context) {
    final styleMap = <String, String>{
      'display': 'flex',
      'flex-direction': 'row',
      'justify-content': _mapMainAxis(mainAxisAlignment),
      'align-items': _mapCrossAxis(crossAxisAlignment),
      'overflow-wrap': 'break-word',
      if (spacing != null) 'gap': '${spacing}px',
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
      id: key?.toString(),
      styles: styleMap,
      children: children.map((child) => child.buildNode(context)).toList(),
    );
  }

  String _mapMainAxis(MainAxisAlignment value) {
    switch (value) {
      case MainAxisAlignment.center:
        return 'center';
      case MainAxisAlignment.end:
        return 'flex-end';
      case MainAxisAlignment.spaceBetween:
        return 'space-between';
      case MainAxisAlignment.spaceAround:
        return 'space-around';
      case MainAxisAlignment.spaceEvenly:
        return 'space-evenly';
      case MainAxisAlignment.start:
        return 'flex-start';
    }
  }

  String _mapCrossAxis(CrossAxisAlignment value) {
    switch (value) {
      case CrossAxisAlignment.center:
        return 'center';
      case CrossAxisAlignment.end:
        return 'flex-end';
      case CrossAxisAlignment.stretch:
        return 'stretch';
      case CrossAxisAlignment.start:
        return 'flex-start';
    }
  }
}
