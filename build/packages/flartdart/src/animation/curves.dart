abstract class Curve {
  const Curve();
  double transform(double t);
}

class _Linear extends Curve {
  const _Linear();
  @override
  double transform(double t) => t;
}

class _Decelerate extends Curve {
  const _Decelerate();
  @override
  double transform(double t) {
    t = 1.0 - t;
    return 1.0 - t * t;
  }
}

class _Ease extends Curve {
  const _Ease();
  @override
  double transform(double t) =>
      0.25 * t * t * t - 0.75 * t * t + 1.5 * t; // Simplified
}

class Curves {
  static const Curve linear = _Linear();
  static const Curve decelerate = _Decelerate();
  static const Curve ease = _Ease();
  static const Curve easeIn = _Linear(); // Placeholders
  static const Curve easeOut = _Linear();
  static const Curve easeInOut = _Linear();
}
