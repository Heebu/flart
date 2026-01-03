import '../../flartdart.dart';
import 'border.dart';
import 'box_gradient.dart';
import 'border_radius.dart';
import 'box_shadow.dart';

class BoxDecoration {
  final FlartColor? color;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final String? image; // URL string
  final Gradient? gradient;

  const BoxDecoration({
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.image,
    this.gradient,
  });

  Map<String, String> toCss() {
    final style = <String, String>{};

    if (color != null) style['background-color'] = color!.toString();

    if (borderRadius != null) {
      style.addAll({
        'border-radius':
        '${borderRadius!.topLeft}px ${borderRadius!.topRight}px ${borderRadius!.bottomRight}px ${borderRadius!.bottomLeft}px',
      });
    }

    if (boxShadow != null && boxShadow!.isNotEmpty) {
      style['box-shadow'] = boxShadow!.map((e) => e.toCss()).join(', ');
    }

    if (border != null) {
      style.addAll(border!.toCss());
    }

    if (gradient != null) {
      style['background-image'] = gradient!.toCss();
    } else if (image != null) {
      style['background-image'] = 'url("$image")';
      style['background-size'] = 'cover';
      style['background-position'] = 'center';
    }

    return style;
  }
}
