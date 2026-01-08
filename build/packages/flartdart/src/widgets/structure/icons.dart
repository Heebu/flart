import '../../../flartdart.dart';

class FDIcon extends Widget {
  final String icon;
  final double size;
  final FlartColor color;
  final String? FDTooltip;

  FDIcon({
    required this.icon,
    this.size = 24.0,
    this.color = const FlartColor('0xFF000000'),
    this.FDTooltip,
  });

  @override
  String render(BuildContext context) {
    final colorHex = color.toString();
    final tooltipAttr = FDTooltip != null ? 'title="$FDTooltip"' : '';

    return '''
      <i class="material-icons" style="font-size: ${size}px; color: $colorHex;" $tooltipAttr>
        $icon
      </i>
    ''';
  }
}

class FDIcons {
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

  static const String refresh = 'refresh';
  static const String delete = 'delete';
  static const String done = 'done';
  static const String check =
      'check'; // Alias for done usually, but using Material names
  static const String check_circle = 'check_circle';
  static const String info = 'info';
  static const String warning = 'warning';
  static const String error = 'error';
  static const String help = 'help';

  static const String arrow_back = 'arrow_back';
  static const String arrow_forward = 'arrow_forward';
  static const String arrow_upward = 'arrow_upward';
  static const String arrow_downward = 'arrow_downward';
  static const String chevron_left = 'chevron_left';
  static const String chevron_right = 'chevron_right';

  static const String play_arrow = 'play_arrow';
  static const String pause = 'pause';
  static const String stop = 'stop';
  static const String volume_up = 'volume_up';
  static const String volume_off = 'volume_off';

  static const String star = 'star';
  static const String star_border = 'star_border';
  static const String share = 'share';
  static const String thumb_up = 'thumb_up';
  static const String thumb_down = 'thumb_down';
  static const String comment = 'comment';
  static const String email = 'email';
  static const String send = 'send';
  static const String notifications = 'notifications';
  static const String account_circle = 'account_circle';

  static const String lock = 'lock';
  static const String lock_open = 'lock_open';
  static const String visibility = 'visibility';
  static const String visibility_off = 'visibility_off';

  static const String more_vert = 'more_vert';
  static const String more_horiz = 'more_horiz';
}




