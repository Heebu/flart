class Alignment {
  final String justifyContent;
  final String alignItems;

  const Alignment(this.justifyContent, this.alignItems);

  static const center = Alignment('center', 'center');
  static const topLeft = Alignment('flex-start', 'flex-start');
  static const topRight = Alignment('flex-end', 'flex-start');
  static const bottomcenter = Alignment('center', 'flex-end');
  static const spaceBetween = Alignment('space-between', 'center');
  static const centerLeft = Alignment('flex-start', 'center');
  static const centerRight = Alignment('flex-end', 'center');
  static const bottomLeft = Alignment('flex-start', 'flex-end');
  static const bottomRight = Alignment('flex-end', 'flex-end');
  static const topCenter = Alignment('center', 'flex-start');

  Map<String, String> toCss() {
    return {
      'display': 'flex',
      'justify-content': justifyContent,
      'align-items': alignItems,
    };
  }
}
