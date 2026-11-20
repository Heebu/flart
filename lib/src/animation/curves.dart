abstract class Curve {
  const Curve();
  double transform(double t);
}

class _Linear extends Curve {
  const _Linear();
  @override
  double transform(double t) => t;
}

/// A cubic polynomial mapping an input time to an output animation progress.
class Cubic extends Curve {
  final double a;
  final double b;
  final double c;
  final double d;

  const Cubic(this.a, this.b, this.c, this.d);

  @override
  double transform(double t) {
    final double t2 = t * t;
    final double t3 = t2 * t;
    final double mt = 1.0 - t;
    final double mt2 = mt * mt;
    return 3.0 * mt2 * t * b + 3.0 * mt * t2 * d + t3;
  }
}

class _Decelerate extends Curve {
  const _Decelerate();
  @override
  double transform(double t) {
    t = 1.0 - t;
    return 1.0 - t * t;
  }
}

/// Standard Flutter animation curves.
class Curves {
  static const Curve linear = _Linear();
  static const Curve decelerate = _Decelerate();

  static const Cubic ease = Cubic(0.25, 0.1, 0.25, 1.0);
  static const Cubic easeIn = Cubic(0.42, 0.0, 1.0, 1.0);
  static const Cubic easeOut = Cubic(0.0, 0.0, 0.58, 1.0);
  static const Cubic easeInOut = Cubic(0.42, 0.0, 0.58, 1.0);
  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  static const Cubic slowMiddle = Cubic(0.15, 0.85, 0.85, 0.15);
  static const Cubic bounceIn = Cubic(0.6, -0.28, 0.735, 0.045);
  static const Cubic bounceOut = Cubic(0.175, 0.885, 0.32, 1.275);
  static const Cubic bounceInOut = Cubic(0.68, -0.55, 0.265, 1.55);
  static const Cubic elasticIn = Cubic(0.5, -0.5, 0.75, 0.0);
  static const Cubic elasticOut = Cubic(0.25, 1.0, 0.5, 1.5);
  static const Cubic elasticInOut = Cubic(0.7, -0.4, 0.3, 1.4);
}

extension CurveCss on Curve {
  String toCss() {
    if (this == Curves.linear) return 'linear';
    if (this is Cubic) {
      final c = this as Cubic;
      return 'cubic-bezier(${c.a}, ${c.b}, ${c.c}, ${c.d})';
    }
    if (this == Curves.decelerate) return 'cubic-bezier(0.0, 0.0, 0.2, 1)';
    return 'ease';
  }
}
