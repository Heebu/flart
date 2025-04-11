class EdgeInsets {
  final double top;
  final double right;
  final double bottom;
  final double left;

  const EdgeInsets.only({this.top = 0, this.right = 0, this.bottom = 0, this.left = 0});
  const EdgeInsets.all(double value)
      : top = value,
        right = value,
        bottom = value,
        left = value;

  String toCss() {
    return '${top}px ${right}px ${bottom}px ${left}px';
  }
}
