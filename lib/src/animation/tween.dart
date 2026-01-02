
abstract class Animatable<T> {
  const Animatable();
  T transform(double t);
}

class Tween<T extends dynamic> extends Animatable<T> {
  Tween({this.begin, this.end});

  final T? begin;
  final T? end;

  @override
  T transform(double t) {
    if (t == 0.0) return begin as T;
    if (t == 1.0) return end as T;
    return lerp(t);
  }

  T lerp(double t) {
    if (begin is double && end is double) {
      return (begin as double) + ((end as double) - (begin as double)) * t as T;
    }
    if (begin is int && end is int) {
      return ((begin as int) + ((end as int) - (begin as int)) * t).round()
          as T;
    }
    // Simple fallback
    return begin as T;
  }
}
