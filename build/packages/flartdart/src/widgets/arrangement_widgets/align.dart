import '../../../flartdart.dart';

class FDAlign extends Widget {
  final Widget child;
  final Aligns alignment;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  FDAlign({
    required this.child,
    this.alignment = Aligns.FDCenter,
    this.cssStyle,
    this.rawCss,
  });

  @override
  String render(BuildContext context) {
    final alignStyle = alignment.toCss();
    final combinedStyle = {
      ...alignStyle,
      ...?cssStyle,
    }.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$combinedStyle ${rawCss ?? ''}">${child.render(context)}</div>';
  }
}
