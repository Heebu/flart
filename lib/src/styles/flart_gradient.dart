import '../../flart.dart';

class FlartGradient {
  final List<FlartColor> colors;
  final String direction;

  const FlartGradient.linear({required this.colors, this.direction = 'to right'});

  String toCss() =>
      'background: linear-gradient($direction, ${colors.map((c) => c.toString()).join(', ')});';
}
