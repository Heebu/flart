class Alignment {
  final String justifyContent;
  final String alignItems;

  const Alignment(this.justifyContent, this.alignItems);

  static const center = Alignment('center', 'center');
  static const topLeft = Alignment('flex-start', 'flex-start');
  static const topRight = Alignment('flex-end', 'flex-start');
  static const bottomCenter = Alignment('center', 'flex-end');
  static const spaceBetween = Alignment('space-between', 'center');

  Map<String, String> toCss() {
    return {
      'display': 'flex',
      'justify-content': justifyContent,
      'align-items': alignItems,
    };
  }
}


