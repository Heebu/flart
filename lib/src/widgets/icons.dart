import '../../flart.dart';

class Icon extends Widget {
  final String icon;
  final double size;
  final FlartColor color;
  final String? tooltip;

  Icon({
    required this.icon,
    this.size = 24.0,
    this.color = const FlartColor('0xFF000000'),
    this.tooltip,
  });

  @override
  String render() {
    final colorHex = color.toString();
    final tooltipAttr = tooltip != null ? 'title="$tooltip"' : '';

    return '''
      <i class="material-icons" style="font-size: ${size}px; color: $colorHex;" $tooltipAttr>
        $icon
      </i>
    ''';
  }
}


class Icons {
  static const String add = 'add';
  static const String home = 'home';
  static const String menu = 'menu';
  static const String search = 'search';
  static const String settings = 'settings';
  static const String close = 'close';
  static const String favorite = 'favorite';
  static const String person = 'person';
  static const String camera = 'camera';
  static const String edit = 'edit';

// Add more as needed...
}

