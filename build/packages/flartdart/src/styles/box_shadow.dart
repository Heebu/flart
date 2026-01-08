import '../../flartdart.dart';

class BoxShadow {
  final double offsetX;
  final double offsetY;
  final double blurRadius;
  final FlartColor color;

  const BoxShadow({
    required this.offsetX,
    required this.offsetY,
    required this.blurRadius,
    required this.color,
  });

  String toCss() =>
      '${offsetX}px ${offsetY}px ${blurRadius}px ${color.toString()}';
}
