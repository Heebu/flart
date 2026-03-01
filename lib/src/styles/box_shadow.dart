import '../../flartdart.dart';

class BoxShadow {
  final double offsetX;
  final double offsetY;
  final Offset? offset;
  final double blurRadius;
  final FlartColor color;

  const BoxShadow({
    this.offsetX = 0,
    this.offsetY = 0,
    this.offset,
    required this.blurRadius,
    required this.color,
  });

  String toCss() {
    final dx = offset?.dx ?? offsetX;
    final dy = offset?.dy ?? offsetY;
    return '${dx}px ${dy}px ${blurRadius}px ${color.toString()}';
  }
}
