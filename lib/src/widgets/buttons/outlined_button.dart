import '../../../flartdart.dart';

typedef OutlinedButton = FDOutlinedButton;

class FDOutlinedButton extends Widget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onHover;
  final Map<String, String>? cssStyle;
  final Map<String, String>? hoverStyle;
  final Map<String, String>? activeStyle;
  final Map<String, String>? disabledStyle;
  final String? rawCss;

  const FDOutlinedButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.cssStyle,
    this.hoverStyle,
    this.activeStyle,
    this.disabledStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.primaryColor.toString();

    final isEnabled = onPressed != null;

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'padding': '10px 16px',
      'font-size': '14px',
      'font-weight': '500',
      'background-color': 'transparent',
      'color': isEnabled ? primary : '#999999',
      'border': '1px solid ${isEnabled ? primary : "#cccccc"}',
      'border-radius': '4px',
      'cursor': isEnabled ? 'pointer' : 'not-allowed',
      'outline': 'none',
      'user-select': 'none',
      'transition': 'all 0.2s ease-in-out',
      'box-sizing': 'border-box',
      if (!isEnabled) 'opacity': '0.6',
      ...?cssStyle,
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styles[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    final events = <String, void Function(dynamic)>{};
    if (isEnabled) {
      events['click'] = (e) => onPressed!();
      if (onHover != null) {
        events['mouseenter'] = (e) => onHover!();
      }
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: {
        'type': 'button',
        if (!isEnabled) 'disabled': 'true',
        'class': 'flart-outlined-button',
      },
      styles: styles,
      events: events,
      children: [child.buildNode(context)],
    );
  }
}
