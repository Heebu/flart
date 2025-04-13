import 'package:flart_project/src/styles/colors.dart';

import '../../flart.dart';

class Border extends BoxBorder {
  final BorderSide? top;
  final BorderSide? right;
  final BorderSide? bottom;
  final BorderSide? left;

  Border({this.top, this.right, this.bottom, this.left});

  factory Border.all({
    BorderSide side = const BorderSide(),
  }) {
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
    this.color =  FlartColors.black,
  });

  String toCss() => '${width}px solid ${color.toString()}';
}


abstract class BoxBorder {
  Map<String, String> toCss();
}
