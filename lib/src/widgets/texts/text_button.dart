import '../../../flartdart.dart';

typedef TextButton = FDTextButton;

class FDTextButton extends Widget {
  final Widget? child;
  final String? label;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDTextButton({
    this.child,
    this.label,
    this.onPressed,
    this.style,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;

    final styles = <String, String>{
      'background': 'none',
      'border': 'none',
      'color': style?.color?.toString() ?? theme.primaryColor.toString(),
      'font-size': style?.fontSize != null ? '${style!.fontSize}px' : '14px',
      'font-weight': '500',
      'cursor': isEnabled ? 'pointer' : 'default',
      'padding': '8px 12px',
      'border-radius': '4px',
      'transition': 'all 0.2s ease-in-out',
      'outline': 'none',
      'user-select': 'none',
      if (!isEnabled) 'opacity': '0.5',
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

    final children = <FlartNode>[];
    if (child != null) {
      children.add(child!.buildNode(context));
    } else if (label != null) {
      children.add(FlartTextNode(label!));
    }

    final events = <String, void Function(dynamic)>{};
    if (isEnabled) {
      events['click'] = (_) => onPressed!();
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: {
        'type': 'button',
        if (!isEnabled) 'disabled': 'true',
        'class': 'flart-text-button',
      },
      styles: styles,
      events: events,
      children: children,
    );
  }
}
