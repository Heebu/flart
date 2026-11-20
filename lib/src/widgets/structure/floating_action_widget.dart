import '../../../flartdart.dart';

typedef FloatingActionButton = FDFloatingActionButton;

class FDFloatingActionButton extends Widget {
  final Widget child;
  final FlartColor? backgroundColor;
  final FlartColor? foregroundColor;
  final VoidCallback? onPressed;
  final double elevation;
  final bool mini;
  final BorderRadius? borderRadius;
  final String? tooltip;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDFloatingActionButton({
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
    this.elevation = 6.0,
    this.mini = false,
    this.borderRadius,
    this.tooltip,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  /// Creates a wider, extended Floating Action Button with an optional icon and label.
  factory FDFloatingActionButton.extended({
    Key? key,
    required Widget label,
    Widget? icon,
    FlartColor? backgroundColor,
    FlartColor? foregroundColor,
    VoidCallback? onPressed,
    double elevation = 6.0,
    BorderRadius? borderRadius,
    String? tooltip,
    Map<String, String>? cssStyle,
    String? rawCss,
  }) {
    return FDFloatingActionButton(
      key: key,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      onPressed: onPressed,
      elevation: elevation,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      tooltip: tooltip,
      cssStyle: cssStyle,
      rawCss: rawCss,
      child: FDRow(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) icon,
          label,
        ],
      ),
    );
  }

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.primaryColor;
    final fg = foregroundColor?.toString() ?? '#ffffff';
    final size = mini ? 40.0 : 56.0;
    final radius = borderRadius?.toCss() ?? (mini ? '20px' : '28px');

    final shadowBlur = elevation * 2;
    final shadowSpread = elevation * 0.3;

    final styles = <String, String>{
      'box-sizing': 'border-box',
      'min-width': '${size}px',
      'min-height': '${size}px',
      'border-radius': radius,
      'background-color': bg.toString(),
      'color': fg,
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'padding': mini ? '0 8px' : '0 16px',
      'box-shadow':
          '0 ${elevation}px ${shadowBlur}px rgba(0,0,0,0.2), 0 ${shadowSpread}px ${elevation * 1.5}px rgba(0,0,0,0.14)',
      'cursor': onPressed != null ? 'pointer' : 'default',
      'user-select': 'none',
      'transition': 'all 0.2s ease-in-out',
      'border': 'none',
      'outline': 'none',
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
    if (onPressed != null) {
      events['click'] = (e) => onPressed!();
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: {
        'class': 'flart-fab',
        if (tooltip != null) 'title': tooltip!,
      },
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [child.buildNode(context)],
    );
  }
}
