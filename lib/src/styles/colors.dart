class FlartColor {
  final String hex;
  const FlartColor(this.hex);

  // Convert hex color to RGB components
  Map<String, int> _hexToRgb() {
    final hexWithoutHash = hex.replaceFirst('#', '');
    final r = int.parse(hexWithoutHash.substring(0, 2), radix: 16);
    final g = int.parse(hexWithoutHash.substring(2, 4), radix: 16);
    final b = int.parse(hexWithoutHash.substring(4, 6), radix: 16);
    return {'r': r, 'g': g, 'b': b};
  }

  // Interpolate between two FlartColor objects
  FlartColor lerp(FlartColor other, double t) {
    final thisRgb = _hexToRgb();
    final otherRgb = other._hexToRgb();

    final r = _lerpComponent(thisRgb['r']!, otherRgb['r']!, t);
    final g = _lerpComponent(thisRgb['g']!, otherRgb['g']!, t);
    final b = _lerpComponent(thisRgb['b']!, otherRgb['b']!, t);

    final hex = _rgbToHex(r, g, b);
    return FlartColor(hex);
  }

  // Helper method to interpolate color components
  int _lerpComponent(int start, int end, double t) {
    return (start + ((end - start) * t)).toInt();
  }

  // Convert RGB values back to hex
  String _rgbToHex(int r, int g, int b) {
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
  }

  @override
  String toString() => hex;
}


class FlartMaterialColor extends FlartColor {
  final Map<int, FlartColor> shades;

  const FlartMaterialColor(super.hex, this.shades);

  FlartColor? operator [](int shade) => shades[shade];

  // Optional sugar access
  FlartColor get shade50 => this[50] ?? this;
  FlartColor get shade100 => this[100] ?? this;
  FlartColor get shade200 => this[200] ?? this;
  FlartColor get shade300 => this[300] ?? this;
  FlartColor get shade400 => this[400] ?? this;
  FlartColor get shade500 => this[500] ?? this;
  FlartColor get shade600 => this[600] ?? this;
  FlartColor get shade700 => this[700] ?? this;
  FlartColor get shade800 => this[800] ?? this;
  FlartColor get shade900 => this[900] ?? this;
}



class FlartColors {
  static const transparent = FlartColor('transparent');
  static const black = FlartColor('#000000');
  static const white = FlartColor('#FFFFFF');

  static const blue = FlartMaterialColor('#2196F3', {
    50: FlartColor('#E3F2FD'),
    100: FlartColor('#BBDEFB'),
    200: FlartColor('#90CAF9'),
    300: FlartColor('#64B5F6'),
    400: FlartColor('#42A5F5'),
    500: FlartColor('#2196F3'),
    600: FlartColor('#1E88E5'),
    700: FlartColor('#1976D2'),
    800: FlartColor('#1565C0'),
    900: FlartColor('#0D47A1'),
  });

  static const red = FlartMaterialColor('#F44336', {
    100: FlartColor('#FFCDD2'),
    200: FlartColor('#EF9A9A'),
    500: FlartColor('#F44336'),
    900: FlartColor('#B71C1C'),
  });

  static const green = FlartMaterialColor('#4CAF50', {
    100: FlartColor('#C8E6C9'),
    200: FlartColor('#A5D6A7'),
    500: FlartColor('#4CAF50'),
    700: FlartColor('#388E3C'),
  });

  static const grey = FlartMaterialColor('#9E9E9E', {
    100: FlartColor('#F5F5F5'),
    300: FlartColor('#E0E0E0'),
    500: FlartColor('#9E9E9E'),
    700: FlartColor('#616161'),
  });

// Add more if you want: orange, yellow, purple etc.
}
