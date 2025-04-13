import '../../flart.dart';

class Gradient {
  final List<FlartColor> colors;
  final String direction; // e.g., 'to right', 'to bottom', etc.

  Gradient({
    required this.colors,
    this.direction = 'to bottom',
  });

  String toCss() {
    final colorStops = colors.map((c) => c.toString()).join(', ');
    return 'linear-gradient($direction, $colorStops)';
  }
}
