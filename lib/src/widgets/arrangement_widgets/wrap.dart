import '../../../flartdart.dart';

/// A widget that displays its children in multiple horizontal or vertical runs
class FDWrap extends Widget {
  final List<Widget> children;
  final Axis direction;
  final MainAxisAlignment
      alignment; // Using main/cross axis alignment enums roughly mapped
  final double spacing; // gap between items
  final double runSpacing; // gap between lines
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDWrap({
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = MainAxisAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final justify = _mapAlignment(alignment);

    final style = {
      'display': 'flex',
      'flex-wrap': 'wrap',
      'flex-direction': direction == Axis.horizontal ? 'row' : 'column',
      'justify-content': justify,
      'gap': '${runSpacing}px ${spacing}px', // row-gap col-gap
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div class="flart-wrap" style="$style ${rawCss ?? ''}">
        ${children.map((c) => c.render(context)).join('')}
      </div>
    ''';
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
