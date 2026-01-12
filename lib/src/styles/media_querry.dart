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

  // Platform & Device Info
  String get platform {
    final userAgent = window.navigator.userAgent.toLowerCase();
    if (userAgent.contains('android')) return 'Android';
    if (userAgent.contains('iphone') ||
        userAgent.contains('ipad') ||
        userAgent.contains('ipod')) return 'iOS';
    if (userAgent.contains('mac os')) return 'macOS';
    if (userAgent.contains('windows')) return 'Windows';
    if (userAgent.contains('linux')) return 'Linux';
    return 'Unknown';
  }

  String get deviceType {
    final userAgent = window.navigator.userAgent.toLowerCase();
    bool isMobileUA = userAgent.contains('mobile') ||
        userAgent.contains('android') ||
        userAgent.contains('iphone');

    // Combine UA check with screen size for better meaningfulness
    if (isSmall && isMobileUA) return 'Mobile';
    if (isMedium) return 'Tablet';
    if (isLarge) return 'Desktop';

    // Fallback if size contradicts UA (e.g. resized desktop window)
    if (isSmall) return 'Mobile (Resized Desktop)';
    return 'Desktop';
  }

  // Device Mode (Theme)
  bool get isDarkMode =>
      window.matchMedia('(prefers-color-scheme: dark)').matches;
  String get mode => isDarkMode ? 'Dark' : 'Light';

  // Browser Info
  String get browser {
    final userAgent = window.navigator.userAgent.toLowerCase();
    if (userAgent.contains('edg')) return 'Edge';
    if (userAgent.contains('chrome')) return 'Chrome';
    if (userAgent.contains('firefox')) return 'Firefox';
    if (userAgent.contains('safari') && !userAgent.contains('chrome'))
      return 'Safari';
    return 'Unknown';
  }

  @override
  String toString() {
    return 'MediaQuery(\n'
        '  Size: {width: $width, height: $height, label: $sizeLabel},\n'
        '  Orientation: $orientation,\n'
        '  Platform: $platform,\n'
        '  Device: $deviceType,\n'
        '  Mode: $mode,\n'
        '  Browser: $browser\n'
        ')';
  }
}
