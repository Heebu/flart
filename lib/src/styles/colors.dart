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

  // Extended Material Colors
  static const purple = FlartMaterialColor('#9C27B0', {
    50: FlartColor('#F3E5F5'),
    100: FlartColor('#E1BEE7'),
    200: FlartColor('#CE93D8'),
    300: FlartColor('#BA68C8'),
    400: FlartColor('#AB47BC'),
    500: FlartColor('#9C27B0'),
    600: FlartColor('#8E24AA'),
    700: FlartColor('#7B1FA2'),
    800: FlartColor('#6A1B9A'),
    900: FlartColor('#4A148C'),
  });

  static const deepPurple = FlartMaterialColor('#673AB7', {
    50: FlartColor('#EDE7F6'),
    100: FlartColor('#D1C4E9'),
    200: FlartColor('#B39DDB'),
    300: FlartColor('#9575CD'),
    400: FlartColor('#7E57C2'),
    500: FlartColor('#673AB7'),
    600: FlartColor('#5E35B1'),
    700: FlartColor('#512DA8'),
    800: FlartColor('#4527A0'),
    900: FlartColor('#311B92'),
  });

  static const indigo = FlartMaterialColor('#3F51B5', {
    50: FlartColor('#E8EAF6'),
    100: FlartColor('#C5CAE9'),
    200: FlartColor('#9FA8DA'),
    300: FlartColor('#7986CB'),
    400: FlartColor('#5C6BC0'),
    500: FlartColor('#3F51B5'),
    600: FlartColor('#3949AB'),
    700: FlartColor('#303F9F'),
    800: FlartColor('#283593'),
    900: FlartColor('#1A237E'),
  });

  // Blue is already defined

  static const lightBlue = FlartMaterialColor('#03A9F4', {
    50: FlartColor('#E1F5FE'),
    100: FlartColor('#B3E5FC'),
    500: FlartColor('#03A9F4'),
    900: FlartColor('#01579B'),
  });

  static const cyan = FlartMaterialColor('#00BCD4', {
    50: FlartColor('#E0F7FA'),
    100: FlartColor('#B2EBF2'),
    500: FlartColor('#00BCD4'),
    900: FlartColor('#006064'),
  });

  static const teal = FlartMaterialColor('#009688', {
    50: FlartColor('#E0F2F1'),
    100: FlartColor('#B2DFDB'),
    500: FlartColor('#009688'),
    900: FlartColor('#004D40'),
  });

  // Green is already defined

  static const lightGreen = FlartMaterialColor('#8BC34A', {
    50: FlartColor('#F1F8E9'),
    100: FlartColor('#DCEDC8'),
    500: FlartColor('#8BC34A'),
    900: FlartColor('#33691E'),
  });

  static const lime = FlartMaterialColor('#CDDC39', {
    50: FlartColor('#F9FBE7'),
    100: FlartColor('#F0F4C3'),
    500: FlartColor('#CDDC39'),
    900: FlartColor('#827717'),
  });

  static const yellow = FlartMaterialColor('#FFEB3B', {
    50: FlartColor('#FFFDE7'),
    100: FlartColor('#FFF9C4'),
    500: FlartColor('#FFEB3B'),
    900: FlartColor('#F57F17'),
  });

  static const amber = FlartMaterialColor('#FFC107', {
    50: FlartColor('#FFF8E1'),
    100: FlartColor('#FFECB3'),
    500: FlartColor('#FFC107'),
    900: FlartColor('#FF6F00'),
  });

  static const orange = FlartMaterialColor('#FF9800', {
    50: FlartColor('#FFF3E0'),
    100: FlartColor('#FFE0B2'),
    500: FlartColor('#FF9800'),
    900: FlartColor('#E65100'),
  });

  static const deepOrange = FlartMaterialColor('#FF5722', {
    50: FlartColor('#FBE9E7'),
    100: FlartColor('#FFCCBC'),
    500: FlartColor('#FF5722'),
    900: FlartColor('#BF360C'),
  });

  static const brown = FlartMaterialColor('#795548', {
    50: FlartColor('#EFEBE9'),
    100: FlartColor('#D7CCC8'),
    500: FlartColor('#795548'),
    900: FlartColor('#3E2723'),
  });

  static const blueGrey = FlartMaterialColor('#607D8B', {
    50: FlartColor('#ECEFF1'),
    100: FlartColor('#CFD8DC'),
    500: FlartColor('#607D8B'),
    900: FlartColor('#263238'),
  });
}
