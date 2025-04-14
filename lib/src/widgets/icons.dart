import '../../flart.dart';
import 'widget.dart';

class Icon extends Widget {
  final String iconName;
  final double size;
  final FlartColor color;
  final String? tooltip;

  Icon({
    required this.iconName,
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
        $iconName
      </i>
    ''';
  }
}
