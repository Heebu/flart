import '../../../flartdart.dart';

typedef IconButton = FDIconButton;

class FDIconButton extends Widget {
  final Widget icon;
  final VoidCallback? onPressed;
  final double? iconSize;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final FlartColor? color;
  final FlartColor? hoverColor;
  final FlartColor? disabledColor;
  final String? tooltip;
  final bool autofocus;
  final ButtonStyle? style;

  const FDIconButton({
    required this.icon,
    this.onPressed,
    this.iconSize = 24.0,
    this.padding,
    this.alignment = Alignment.center,
    this.color,
    this.hoverColor,
    this.disabledColor,
    this.tooltip,
    this.autofocus = false,
    this.style,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = context.theme;
    final isEnabled = onPressed != null;

    final effectiveColor = isEnabled
        ? (color ?? style?.foregroundColor ?? theme.primaryColor)
        : (disabledColor ?? FlartColor('#94a3b8'));

    final effectiveBg = isEnabled
        ? (style?.backgroundColor?.toString() ?? 'transparent')
        : 'transparent';

    final pad = padding ?? style?.padding ?? const EdgeInsets.all(8);
    final size = iconSize ?? 24.0;

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'box-sizing': 'border-box',
      'padding': pad.toCss(),
      'width': '${size + (pad.horizontal)}px',
      'height': '${size + (pad.vertical)}px',
      'font-size': '${size}px',
      'border': style?.side?.toCss() ?? 'none',
      'background-color': effectiveBg,
      'color': effectiveColor.toString(),
      'border-radius': style?.shape?.toCss() ?? '50%',
      'cursor': isEnabled ? 'pointer' : 'not-allowed',
      'outline': 'none',
      'user-select': 'none',
      'transition': 'all 0.15s ease-in-out',
      if (!isEnabled) 'opacity': '0.5',
    };

    final attributes = <String, String>{
      'type': 'button',
      if (!isEnabled) 'disabled': '',
      if (autofocus) 'autofocus': '',
      if (tooltip != null) 'title': tooltip!,
      if (tooltip != null) 'aria-label': tooltip!,
      'class': 'flart-icon-button',
    };

    final events = <String, void Function(dynamic)>{};
    if (isEnabled) {
      events['click'] = (e) => onPressed!();
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: attributes,
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [icon.buildNode(context)],
    );
  }
}
