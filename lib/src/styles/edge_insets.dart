class EdgeInsets {
  final double top;
  final double right;
  final double bottom;
  final double left;

  const EdgeInsets.only(
      {this.top = 0, this.right = 0, this.bottom = 0, this.left = 0});
  const EdgeInsets.all(double value)
      : top = value,
        right = value,
        bottom = value,
        left = value;

  const EdgeInsets.symmetric({double vertical = 0, double horizontal = 0})
      : top = vertical,
        right = horizontal,
        bottom = vertical,
        left = horizontal;

  String toCss() {
    return '${top}px ${right}px ${bottom}px ${left}px';
  }
}
