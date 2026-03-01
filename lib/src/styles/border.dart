import 'colors.dart';
import '../../flartdart.dart';

class Border extends BoxBorder {
  final BorderSide? top;
  final BorderSide? right;
  final BorderSide? bottom;
  final BorderSide? left;

  const Border({this.top, this.right, this.bottom, this.left});

  factory Border.all({
    FlartColor color = FlartColors.black,
    double width = 1.0,
  }) {
    final side = BorderSide(color: color, width: width);
    return Border(
      top: side,
      right: side,
      bottom: side,
      left: side,
    );
  }

  @override
  Map<String, String> toCss() {
    final css = <String, String>{};

    if (top != null) css['border-top'] = top!.toCss();
    if (right != null) css['border-right'] = right!.toCss();
    if (bottom != null) css['border-bottom'] = bottom!.toCss();
    if (left != null) css['border-left'] = left!.toCss();

    return css;
  }
}

class BorderSide {
  final double width;
  final FlartColor color;

  const BorderSide({
    this.width = 1.0,
    this.color = FlartColors.black,
  });

  String toCss() => '${width}px solid ${color.toString()}';
}

abstract class BoxBorder {
  const BoxBorder();
  Map<String, String> toCss();
}
