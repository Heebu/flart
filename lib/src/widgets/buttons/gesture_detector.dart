import '../../../flartdart.dart';
import '../../helper/callback_manager.dart';

/// Global counter for unique gesture detector IDs (avoids microsecond collisions).
int _gestureCounter = 0;

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
    final events = <String, Function(dynamic)>{};

    if (onTap != null) events['click'] = (e) => onTap!();
    if (onDoubleTap != null) events['dblclick'] = (e) => onDoubleTap!();

    if (onTapDown != null || onMouseDown != null) {
      events['mousedown'] = (e) {
        onTapDown?.call();
        onMouseDown?.call();
      };
    }

    if (onTapUp != null || onMouseUp != null) {
      events['mouseup'] = (e) {
        onTapUp?.call();
        onMouseUp?.call();
      };
    }

    if (onHover != null || onHoverEnter != null) {
      events['mouseenter'] = (e) {
        onHover?.call();
        onHoverEnter?.call();
      };
    }

    if (onHoverExit != null) events['mouseleave'] = (e) => onHoverExit!();
    if (onMouseMove != null) events['mousemove'] = (e) => onMouseMove!();
    
    if (onContextMenu != null) {
      events['contextmenu'] = (e) {
        // e.preventDefault() in JS
        final target = e;
        try {
          // Dynamic call for preventDefault
          // package:web Event has preventDefault
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
      // For VDOM, we can attach touchstart and touchend
      // Since Dart JS interop limits closure state, we can use an Expando or global map
      // Or just assume the user will handle complex gestures with a proper gesture arena later.
      // We will map simple touchstart/touchend.
      // Wait, we can hold state in the closure! Dart closures capture variables perfectly.
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

    // Long press
    if (onLongPress != null) {
      // Capture timeout ID or future
      // Wait, setTimeout returns an ID in JS, in Dart we can use Future
      bool _isLongPressCanceled = false;
      events['mousedown'] = (e) {
        _isLongPressCanceled = false;
        Future.delayed(const Duration(milliseconds: 700), () {
          if (!_isLongPressCanceled) {
            onLongPress!();
          }
        });
      };
      events['mouseup'] = (e) => _isLongPressCanceled = true;
      events['mouseleave'] = (e) => _isLongPressCanceled = true;
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
      id: key?.toString() ?? 'gesture_${_gestureCounter++}',
      attributes: {'tabindex': '0'},
      styles: styleMap,
      events: events,
      children: [child],
    ).buildNode(context);
  }
}
