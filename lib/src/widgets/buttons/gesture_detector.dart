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
  String render(BuildContext context) {
    final id = 'gesture_${_gestureCounter++}';

    // Build inline event attributes using FlartCallbackManager
    final events = StringBuffer();

    if (onTap != null) {
      final cbId = FlartCallbackManager.register(onTap!);
      events.write(' onclick="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onDoubleTap != null) {
      final cbId = FlartCallbackManager.register(onDoubleTap!);
      events.write(' ondblclick="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onTapDown != null || onMouseDown != null) {
      final cb = onTapDown ?? onMouseDown!;
      final cbId = FlartCallbackManager.register(cb);
      events.write(' onmousedown="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onTapUp != null || onMouseUp != null) {
      final cb = onTapUp ?? onMouseUp!;
      final cbId = FlartCallbackManager.register(cb);
      events.write(' onmouseup="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onHover != null || onHoverEnter != null) {
      final handlers = <VoidCallback>[];
      if (onHover != null) handlers.add(onHover!);
      if (onHoverEnter != null) handlers.add(onHoverEnter!);
      final cbId = FlartCallbackManager.register(() {
        for (final h in handlers) {
          h();
        }
      });
      events.write(' onmouseenter="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onHoverExit != null) {
      final cbId = FlartCallbackManager.register(onHoverExit!);
      events.write(' onmouseleave="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onMouseMove != null) {
      final cbId = FlartCallbackManager.register(onMouseMove!);
      events.write(' onmousemove="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onContextMenu != null) {
      final cbId = FlartCallbackManager.register(onContextMenu!);
      events.write(
          ' oncontextmenu="event.preventDefault(); window.__flartHandleClick(\'$cbId\')"');
    }

    if (onFocus != null) {
      final cbId = FlartCallbackManager.register(onFocus!);
      events.write(' onfocus="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onBlur != null) {
      final cbId = FlartCallbackManager.register(onBlur!);
      events.write(' onblur="window.__flartHandleClick(\'$cbId\')"');
    }

    if (onScroll != null) {
      final cbId = FlartCallbackManager.register(onScroll!);
      events.write(' onwheel="window.__flartHandleClick(\'$cbId\')"');
    }

    // Swipe detection via inline JS (touch events)
    String swipeScript = '';
    if (onSwipeLeft != null ||
        onSwipeRight != null ||
        onSwipeUp != null ||
        onSwipeDown != null) {
      final leftId =
          onSwipeLeft != null ? FlartCallbackManager.register(onSwipeLeft!) : '';
      final rightId = onSwipeRight != null
          ? FlartCallbackManager.register(onSwipeRight!)
          : '';
      final upId =
          onSwipeUp != null ? FlartCallbackManager.register(onSwipeUp!) : '';
      final downId = onSwipeDown != null
          ? FlartCallbackManager.register(onSwipeDown!)
          : '';

      swipeScript = '''
        <script>
        (function(){
          var el = document.getElementById('$id');
          if (!el) return;
          var sx=0, sy=0;
          el.addEventListener('touchstart', function(e) {
            if (e.touches.length > 0) { sx=e.touches[0].clientX; sy=e.touches[0].clientY; }
          });
          el.addEventListener('touchend', function(e) {
            if (e.changedTouches.length > 0) {
              var dx=e.changedTouches[0].clientX-sx, dy=e.changedTouches[0].clientY-sy;
              var ax=Math.abs(dx), ay=Math.abs(dy);
              if (ax>ay && ax>30) {
                ${rightId.isNotEmpty ? "if(dx>0) window.__flartHandleClick('$rightId');" : ''}
                ${leftId.isNotEmpty ? "if(dx<0) window.__flartHandleClick('$leftId');" : ''}
              } else if (ay>ax && ay>30) {
                ${downId.isNotEmpty ? "if(dy>0) window.__flartHandleClick('$downId');" : ''}
                ${upId.isNotEmpty ? "if(dy<0) window.__flartHandleClick('$upId');" : ''}
              }
            }
          });
        })();
        </script>
      ''';
    }

    // Long press detection via inline JS
    String longPressScript = '';
    if (onLongPress != null) {
      final lpId = FlartCallbackManager.register(onLongPress!);
      longPressScript = '''
        <script>
        (function(){
          var el = document.getElementById('$id');
          if (!el) return;
          var t;
          el.addEventListener('mousedown', function() { t = setTimeout(function(){ window.__flartHandleClick('$lpId'); }, 700); });
          el.addEventListener('mouseup', function() { clearTimeout(t); });
          el.addEventListener('mouseleave', function() { clearTimeout(t); });
        })();
        </script>
      ''';
    }

    final cursor = onTap != null ? 'cursor: pointer;' : '';
    return '<div id="$id" tabindex="0" style="outline: none; display: inline-block; $cursor ${rawCss ?? ''}"${events.toString()}>${child.render(context)}</div>$swipeScript$longPressScript';
  }
}
