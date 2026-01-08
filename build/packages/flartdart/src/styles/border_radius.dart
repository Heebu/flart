class BorderRadius {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  const BorderRadius.only({
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });

  const BorderRadius.all(double radius)
      : topLeft = radius,
        topRight = radius,
        bottomLeft = radius,
        bottomRight = radius;

  const BorderRadius.circular(double radius)
      : topLeft = radius,
        topRight = radius,
        bottomLeft = radius,
        bottomRight = radius;

  const BorderRadius.vertical({double top = 0, double bottom = 0})
      : topLeft = top,
        topRight = top,
        bottomLeft = bottom,
        bottomRight = bottom;

  const BorderRadius.horizontal({double left = 0, double right = 0})
      : topLeft = left,
        bottomLeft = left,
        topRight = right,
        bottomRight = right;

  static const BorderRadius zero = BorderRadius.all(0);

  String toCss() {
    return 'border-radius: ${topLeft}px ${topRight}px ${bottomRight}px ${bottomLeft}px;';
  }
}
