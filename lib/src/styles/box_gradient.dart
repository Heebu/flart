import '../../flartdart.dart';

typedef LinearGradient = Gradient;

class Gradient {
  final List<FlartColor> colors;
  final String direction;

  const Gradient({
    required this.colors,
    this.direction = 'to bottom',
  });

  String toCss() {
    final colorStops = colors.map((c) => c.toString()).join(', ');
    return 'linear-gradient($direction, $colorStops)';
  }
}
