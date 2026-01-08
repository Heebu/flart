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
  String render(BuildContext context) {
    final isVertical = scrollDirection == Axis.vertical;
    final style = {
      'overflow-x': isVertical ? 'hidden' : 'auto',
      'overflow-y': isVertical ? 'auto' : 'hidden',
      'display': 'block',
      if (padding != null) 'padding': padding!.toCss(),
      'width': '100%',
      'height': '100%',
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '''
      <div class="flart-scroll-view" style="$style ${rawCss ?? ''}">
        ${child.render(context)}
      </div>
    ''';
  }
}
