import '../../../flartdart.dart';

/// A widget that insets its child by the given padding.
class FDPadding extends Widget {
  final EdgeInsets padding;
  final Widget child;
  final String? rawCss;

  FDPadding({
    required this.padding,
    required this.child,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    return '''
      <div style="padding: ${padding.toCss()}; box-sizing: border-box; ${rawCss ?? ''}">
        ${child.render(context)}
      </div>
    ''';
  }
}
