class align {
  final String x;
  final String y;

  const align(this.x, this.y);

  static const topLeft = align('flex-start', 'flex-start');
  static const topCenter = align('center', 'flex-start');
  static const topRight = align('flex-end', 'flex-start');

  static const centerLeft = align('flex-start', 'center');
  static const center = align('center', 'center');
  static const centerRight = align('flex-end', 'center');

  static const bottomLeft = align('flex-start', 'flex-end');
  static const bottomCenter = align('center', 'flex-end');
  static const bottomRight = align('flex-end', 'flex-end');

  Map<String, String> toCss() => {
    'display': 'flex',
    'justify-content': x,
    'align-items': y,
  };
}
