class Aligns {
  final String x;
  final String y;

  const Aligns(this.x, this.y);

  static const topLeft = Aligns('flex-start', 'flex-start');
  static const topCenter = Aligns('center', 'flex-start');
  static const topRight = Aligns('flex-end', 'flex-start');

  static const centerLeft = Aligns('flex-start', 'center');
  static const center = Aligns('center', 'center');
  static const centerRight = Aligns('flex-end', 'center');

  static const bottomLeft = Aligns('flex-start', 'flex-end');
  static const bottomCenter = Aligns('center', 'flex-end');
  static const bottomRight = Aligns('flex-end', 'flex-end');

  Map<String, String> toCss() => {
    'display': 'flex',
    'justify-content': x,
    'align-items': y,
  };
}
