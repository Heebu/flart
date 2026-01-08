import '../../../flartdart.dart';

/// A widget that imposes additional constraints on its child.
class FDConstrainedBox extends Widget {
  final BoxConstraints constraints;
  final Widget child;
  final String? rawCss;

  FDConstrainedBox({
    required this.constraints,
    required this.child,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    return '''
      <div style="${constraints.toCss()}; box-sizing: border-box; ${rawCss ?? ''}">
        ${child.render(context)}
      </div>
    ''';
  }
}

class BoxConstraints {
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  const BoxConstraints({
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  });

  String toCss() {
    final style = <String, String>{};
    if (minWidth > 0) style['min-width'] = '${minWidth}px';
    if (maxWidth != double.infinity) style['max-width'] = '${maxWidth}px';
    if (minHeight > 0) style['min-height'] = '${minHeight}px';
    if (maxHeight != double.infinity) style['max-height'] = '${maxHeight}px';

    return style.entries.map((e) => '${e.key}: ${e.value}').join('; ');
  }
}
