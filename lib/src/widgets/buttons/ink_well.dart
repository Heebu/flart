import '../../../flartdart.dart';

typedef InkWell = FDInkWell;

class FDInkWell extends Widget {
  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final BorderRadius? borderRadius;
  final FlartColor? splashColor;
  final FlartColor? highlightColor;
  final FlartColor? hoverColor;
  final Map<String, String>? cssStyle;
  final String? rawCss;

  const FDInkWell({
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.cssStyle,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.zero;

    final styles = <String, String>{
      'position': 'relative',
      'overflow': 'hidden',
      'cursor': onTap != null ? 'pointer' : 'default',
      'user-select': 'none',
      'border-radius': radius.toCss(),
      'transition': 'background-color 0.15s ease-in-out',
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
    if (onTap != null) {
      events['click'] = (_) => onTap!();
    }
    if (onDoubleTap != null) {
      events['dblclick'] = (_) => onDoubleTap!();
    }
    if (onHover != null) {
      events['mouseenter'] = (_) => onHover!(true);
      events['mouseleave'] = (_) => onHover!(false);
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: {'class': 'flart-ink-well'},
      styles: styles,
      events: events,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
