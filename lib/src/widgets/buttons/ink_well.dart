import 'dart:async';
import 'package:web/web.dart' as web;
import '../../../flartdart.dart';

typedef InkWell = FDInkWell;

class FDInkWell extends Widget {
  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final BorderRadius? borderRadius;
  final FlartColor? splashColor;
  final FlartColor? highlightColor;
  final FlartColor? hoverColor;

  const FDInkWell({
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onHover,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.zero;
    final isInteractive =
        onTap != null || onDoubleTap != null || onLongPress != null;

    final defaultHover = hoverColor?.toString() ?? 'rgba(0, 0, 0, 0.05)';
    final defaultSplash =
        (splashColor ?? highlightColor)?.toString() ?? 'rgba(0, 0, 0, 0.10)';

    final styles = <String, String>{
      'position': 'relative',
      'overflow': 'hidden',
      'cursor': isInteractive ? 'pointer' : 'default',
      'user-select': 'none',
      'border-radius': radius.toCss(),
      'transition': 'background-color 0.15s cubic-bezier(0.4, 0, 0.2, 1)',
      'box-sizing': 'border-box',
    };

    final events = <String, void Function(dynamic)>{};

    events['mouseenter'] = (e) {
      try {
        (e.target as web.HTMLElement).style.backgroundColor = defaultHover;
      } catch (_) {}
      onHover?.call(true);
    };

    events['mouseleave'] = (e) {
      try {
        (e.target as web.HTMLElement).style.backgroundColor = 'transparent';
      } catch (_) {}
      onHover?.call(false);
      onTapCancel?.call();
    };

    bool isLongPressCanceled = false;

    events['mousedown'] = (e) {
      try {
        (e.target as web.HTMLElement).style.backgroundColor = defaultSplash;
      } catch (_) {}
      onTapDown?.call();

      if (onLongPress != null) {
        isLongPressCanceled = false;
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!isLongPressCanceled) {
            onLongPress!();
          }
        });
      }
    };

    events['mouseup'] = (e) {
      try {
        (e.target as web.HTMLElement).style.backgroundColor = defaultHover;
      } catch (_) {}
      isLongPressCanceled = true;
      onTapUp?.call();
    };

    if (onTap != null) {
      events['click'] = (_) => onTap!();
    }
    if (onDoubleTap != null) {
      events['dblclick'] = (_) => onDoubleTap!();
    }

    return FlartElementNode(
      'div',
      id: key?.toString(),
      attributes: const {'class': 'flart-ink-well'},
      styles: styles,
      events: events,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}
