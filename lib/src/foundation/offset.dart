class Offset {
  final double dx;
  final double dy;

  const Offset(this.dx, this.dy);

  static const zero = Offset(0, 0);

  @override
  String toString() => 'Offset($dx, $dy)';

  Offset operator +(Offset other) => Offset(dx + other.dx, dy + other.dy);
  Offset operator -(Offset other) => Offset(dx - other.dx, dy - other.dy);
  Offset operator *(double operand) => Offset(dx * operand, dy * operand);
  Offset operator /(double operand) => Offset(dx / operand, dy / operand);
}
