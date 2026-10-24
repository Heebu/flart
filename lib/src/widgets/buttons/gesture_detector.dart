import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';


/// Detects various user interactions (tap, double-tap, hover, swipe, etc.).
///
/// Uses the unified [FlartCallbackManager] callback bridge for all event
/// handling, ensuring a single consistent event architecture across the
/// framework.
class FDGestureDetector extends Widget {
  final Widget child;

  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;

  final VoidCallback? onHover;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;

  final VoidCallback? onPanStart;
  final VoidCallback? onPanUpdate;
  final VoidCallback? onPanEnd;

  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;

  final VoidCallback? onContextMenu;

  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

  final VoidCallback? onMouseDown;
  final VoidCallback? onMouseUp;
  final VoidCallback? onMouseMove;

  final VoidCallback? onScroll;
  final String? rawCss;

  const FDGestureDetector({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onHover,
    this.onHoverEnter,
    this.onHoverExit,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onContextMenu,
    this.onFocus,
    this.onBlur,
    this.onMouseDown,
    this.onMouseUp,
    this.onMouseMove,
    this.onScroll,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final events = <String, void Function(dynamic)>{};

    if (onTap != null) events['click'] = (e) => onTap!();
    if (onDoubleTap != null) events['dblclick'] = (e) => onDoubleTap!();

    bool isLongPressCanceled = false;

    if (onTapDown != null || onMouseDown != null || onLongPress != null) {
      events['mousedown'] = (e) {
        onTapDown?.call();
        onMouseDown?.call();
        if (onLongPress != null) {
          isLongPressCanceled = false;
          Future.delayed(const Duration(milliseconds: 700), () {
            if (!isLongPressCanceled) {
              onLongPress!();
            }
          });
        }
      };
    }

    if (onTapUp != null || onMouseUp != null || onLongPress != null) {
      events['mouseup'] = (e) {
        onTapUp?.call();
        onMouseUp?.call();
        if (onLongPress != null) {
          isLongPressCanceled = true;
        }
      };
    }

    if (onHover != null || onHoverEnter != null) {
      events['mouseenter'] = (e) {
        onHover?.call();
        onHoverEnter?.call();
      };
    }

    if (onHoverExit != null || onLongPress != null) {
      events['mouseleave'] = (e) {
        onHoverExit?.call();
        if (onLongPress != null) {
          isLongPressCanceled = true;
        }
      };
    }

    if (onMouseMove != null) events['mousemove'] = (e) => onMouseMove!();
    
    if (onContextMenu != null) {
      events['contextmenu'] = (e) {
        final target = e;
        try {
          (target as dynamic).preventDefault();
        } catch (_) {}
        onContextMenu!();
      };
    }

    if (onFocus != null) events['focus'] = (e) => onFocus!();
    if (onBlur != null) events['blur'] = (e) => onBlur!();
    if (onScroll != null) events['wheel'] = (e) => onScroll!();

    // Swipe detection (basic touch event mapping)
    if (onSwipeLeft != null ||
        onSwipeRight != null ||
        onSwipeUp != null ||
        onSwipeDown != null) {
      double sx = 0, sy = 0;
      
      events['touchstart'] = (e) {
        try {
          final touches = (e as dynamic).touches;
          if (touches != null && (touches.length as int) > 0) {
            sx = touches[0].clientX as double;
            sy = touches[0].clientY as double;
          }
        } catch (_) {}
      };
      
      events['touchend'] = (e) {
        try {
          final changedTouches = (e as dynamic).changedTouches;
          if (changedTouches != null && (changedTouches.length as int) > 0) {
            double ex = changedTouches[0].clientX as double;
            double ey = changedTouches[0].clientY as double;
            double dx = ex - sx;
            double dy = ey - sy;
            double ax = dx.abs();
            double ay = dy.abs();
            if (ax > ay && ax > 30) {
              if (dx > 0) onSwipeRight?.call();
              if (dx < 0) onSwipeLeft?.call();
            } else if (ay > ax && ay > 30) {
              if (dy > 0) onSwipeDown?.call();
              if (dy < 0) onSwipeUp?.call();
            }
          }
        } catch (_) {}
      };
    }

    final styleMap = <String, String>{
      'outline': 'none',
      'display': 'inline-block',
      if (onTap != null) 'cursor': 'pointer',
    };

    if (rawCss != null && rawCss!.isNotEmpty) {
      final pairs = rawCss!.split(';');
      for (var pair in pairs) {
        if (pair.trim().isEmpty) continue;
        final parts = pair.split(':');
        if (parts.length >= 2) {
          styleMap[parts[0].trim()] = parts.sublist(1).join(':').trim();
        }
      }
    }

    return FDElement(
      tag: 'div',
      key: key,
      id: key?.toString(),
      attributes: {'tabindex': '0'},
      styles: styleMap,
      events: events,
      children: [child],
    ).buildNode(context);
  }
}
