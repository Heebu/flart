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

    final isUniform = top != null &&
        right != null &&
        bottom != null &&
        left != null &&
        top == right &&
        right == bottom &&
        bottom == left;

    if (isUniform) {
      css['border'] = top!.toCss();
    } else {
      if (top != null) css['border-top'] = top!.toCss();
      if (right != null) css['border-right'] = right!.toCss();
      if (bottom != null) css['border-bottom'] = bottom!.toCss();
      if (left != null) css['border-left'] = left!.toCss();
    }

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorderSide &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          color.toString() == other.color.toString();

  @override
  int get hashCode => width.hashCode ^ color.toString().hashCode;
}

abstract class BoxBorder {
  const BoxBorder();
  Map<String, String> toCss();
}
