abstract class ShapeBorder {
  const ShapeBorder();
}

class CircleBorder extends ShapeBorder {
  const CircleBorder();
}

class RoundedRectangleBorder extends ShapeBorder {
  final double radius;
  const RoundedRectangleBorder({this.radius = 4.0});
}

enum Clip {
  none,
  hardEdge,
  antiAlias,
  antiAliasWithSaveLayer,
}
