import '../../flartdart.dart';

typedef LinearGradient = Gradient;

class Gradient {
  final List<FlartColor> colors;
  final String direction;
  final Alignment? begin;
  final Alignment? end;

  const Gradient({
    required this.colors,
    this.direction = 'to bottom',
    this.begin,
    this.end,
  });

  String toCss() {
    var effectiveDirection = direction;
    if (begin != null && end != null) {
      if (begin == Alignment.topLeft && end == Alignment.bottomRight) {
        effectiveDirection = 'to bottom right';
      } else if (begin == Alignment.topCenter && end == Alignment.bottomCenter) {
        effectiveDirection = 'to bottom';
      } else if (begin == Alignment.centerLeft && end == Alignment.centerRight) {
        effectiveDirection = 'to right';
      }
    }
    final colorStops = colors.map((c) => c.toString()).join(', ');
    return 'linear-gradient($effectiveDirection, $colorStops)';
  }
}
