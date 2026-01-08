
import '../../../flartdart.dart';
import '../widget.dart';
import '../../styles/box_decoration.dart';
import '../../styles/edge_insets.dart';
import '../../styles/alignment.dart';

class FDContainer extends Widget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final Alignment? alignment;
  final Map<String, String>? cssStyle;

  FDContainer({
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.cssStyle,
  });

  @override
  String render(BuildContext context) {
    final styleMap = <String, String>{
      if (width != null) 'width': '${width}px',
      if (height != null) 'height': '${height}px',
      if (padding != null) 'padding': padding!.toCss(),
      if (margin != null) 'margin': margin!.toCss(),
      ...?decoration?.toCss(),
      ...?alignment?.toCss(),
      ...?cssStyle,
    };

    final styleString =
        styleMap.entries.map((e) => '${e.key}: ${e.value};').join(' ');

    return '<div style="$styleString">${child?.render(context) ?? ''}</div>';
  }
}



