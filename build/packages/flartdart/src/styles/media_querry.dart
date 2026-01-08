import 'dart:html';

class MediaQuery {
  final num width;
  final num height;

  MediaQuery._(this.width, this.height);

  static MediaQuery of() {
    final width = window.innerWidth ?? 0;
    final height = window.innerHeight ?? 0;
    return MediaQuery._(width, height);
  }

  // Breakpoints
  bool get isSmall => width < 600;
  bool get isMedium => width >= 600 && width < 1024;
  bool get isLarge => width >= 1024;

  String get sizeLabel {
    if (isSmall) return 'small';
    if (isMedium) return 'medium';
    return 'large';
  }

  // Orientation
  bool get isPortrait => height >= width;
  bool get isLandscape => width > height;

  String get orientation => isPortrait ? 'portrait' : 'landscape';

  @override
  String toString() {
    return 'MediaQuery(width: $width, height: $height, size: $sizeLabel, orientation: $orientation)';
  }
}
