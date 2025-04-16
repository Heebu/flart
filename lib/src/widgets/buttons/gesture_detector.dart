import 'dart:html';
import '../../../flart.dart';
import '../../helper/callback_manager.dart';


class GestureDetector extends Widget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleClick;
  final VoidCallback? onLongPress;
  final VoidCallback? onHover;
  final VoidCallback? onHoverExit;
  final VoidCallback? onContextMenu;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;

  GestureDetector({
    required this.child,
    this.onTap,
    this.onDoubleClick,
    this.onLongPress,
    this.onHover,
    this.onHoverExit,
    this.onContextMenu,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
  });

  @override
  String render() {
    final id = 'gesture_${DateTime.now().millisecondsSinceEpoch}';
    final buffer = StringBuffer();

    buffer.writeln('<div id="$id">${child.render()}</div>');

    buffer.writeln('''
    <script>
      (function() {
        const el = document.getElementById('$id');
        let longPressTimeout, startX, startY;

        ${onTap != null ? "el.addEventListener('click', () => window.__flartHandleClick('${FlartCallbackManager.register(onTap!)}'));" : ''}
        ${onDoubleClick != null ? "el.addEventListener('dblclick', () => window.__flartHandleClick('${FlartCallbackManager.register(onDoubleClick!)}'));" : ''}
        ${onLongPress != null ? '''
          el.addEventListener('mousedown', () => {
            longPressTimeout = setTimeout(() => {
              window.__flartHandleClick('${FlartCallbackManager.register(onLongPress!)}');
            }, 700);
          });
          el.addEventListener('mouseup', () => clearTimeout(longPressTimeout));
          el.addEventListener('mouseleave', () => clearTimeout(longPressTimeout));
        ''' : ''}

        ${onHover != null ? "el.addEventListener('mouseenter', () => window.__flartHandleClick('${FlartCallbackManager.register(onHover!)}'));" : ''}
        ${onHoverExit != null ? "el.addEventListener('mouseleave', () => window.__flartHandleClick('${FlartCallbackManager.register(onHoverExit!)}'));" : ''}
        ${onContextMenu != null ? "el.addEventListener('contextmenu', (e) => { e.preventDefault(); window.__flartHandleClick('${FlartCallbackManager.register(onContextMenu!)}'); });" : ''}

        // Swipe Detection
        el.addEventListener('touchstart', function(e) {
          const t = e.touches[0];
          startX = t.clientX;
          startY = t.clientY;
        });

        el.addEventListener('touchend', function(e) {
          const t = e.changedTouches[0];
          const dx = t.clientX - startX;
          const dy = t.clientY - startY;
          const absDx = Math.abs(dx);
          const absDy = Math.abs(dy);

          if (Math.max(absDx, absDy) > 30) {
            if (absDx > absDy) {
              if (dx > 0) {
                ${onSwipeRight != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onSwipeRight!)}');" : ''}
              } else {
                ${onSwipeLeft != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onSwipeLeft!)}');" : ''}
              }
            } else {
              if (dy > 0) {
                ${onSwipeDown != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onSwipeDown!)}');" : ''}
              } else {
                ${onSwipeUp != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onSwipeUp!)}');" : ''}
              }
            }
          }
        });
      })();
    </script>
    ''');

    return buffer.toString();
  }
}
