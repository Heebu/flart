import '../../../flart.dart';
import '../../helper/callback_manager.dart';

class GestureDetector extends Widget {
  final Widget child;

  // Tap events
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;

  // Hover events
  final VoidCallback? onHover;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;

  // Drag/Pan events
  final VoidCallback? onPanStart;
  final VoidCallback? onPanUpdate;
  final VoidCallback? onPanEnd;

  // Swipe events
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;

  // Context menu
  final VoidCallback? onContextMenu;

  // Focus events
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

  // Mouse events
  final VoidCallback? onMouseDown;
  final VoidCallback? onMouseUp;
  final VoidCallback? onMouseMove;

  // Wheel/Scroll events
  final VoidCallback? onScroll;

  GestureDetector({
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
  });

  @override
  String render(BuildContext context) {
    final id = 'gesture_${DateTime.now().microsecondsSinceEpoch}';
    final buffer = StringBuffer();

    buffer.writeln(
        '<div id="$id" tabindex="0" style="outline: none;">${child.render(context)}</div>');

    buffer.writeln('''
    <script>
      (function() {
        const el = document.getElementById('$id');
        let longPressTimeout, startX, startY, isPanning = false;

        // Tap events
        ${onTap != null ? "el.addEventListener('click', () => window.__flartHandleClick('${FlartCallbackManager.register(onTap!)}'));" : ''}
        
        ${onDoubleTap != null ? "el.addEventListener('dblclick', () => window.__flartHandleClick('${FlartCallbackManager.register(onDoubleTap!)}'));" : ''}
        
        ${onTapDown != null ? "el.addEventListener('mousedown', () => window.__flartHandleClick('${FlartCallbackManager.register(onTapDown!)}'));" : ''}
        
        ${onTapUp != null ? "el.addEventListener('mouseup', () => window.__flartHandleClick('${FlartCallbackManager.register(onTapUp!)}'));" : ''}
        
        // Long press
        ${onLongPress != null ? '''
          el.addEventListener('mousedown', () => {
            longPressTimeout = setTimeout(() => {
              window.__flartHandleClick('${FlartCallbackManager.register(onLongPress!)}');
            }, 700);
          });
          el.addEventListener('mouseup', () => clearTimeout(longPressTimeout));
          el.addEventListener('mouseleave', () => clearTimeout(longPressTimeout));
        ''' : ''}

        // Hover events
        ${onHover != null || onHoverEnter != null ? '''
          el.addEventListener('mouseenter', () => {
            ${onHover != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onHover!)}');" : ''}
            ${onHoverEnter != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onHoverEnter!)}');" : ''}
          });
        ''' : ''}
        
        ${onHoverExit != null ? "el.addEventListener('mouseleave', () => window.__flartHandleClick('${FlartCallbackManager.register(onHoverExit!)}'));" : ''}

        // Pan/Drag events
        ${onPanStart != null || onPanUpdate != null || onPanEnd != null ? '''
          el.addEventListener('mousedown', function(e) {
            isPanning = true;
            startX = e.clientX;
            startY = e.clientY;
            ${onPanStart != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onPanStart!)}');" : ''}
          });
          
          el.addEventListener('mousemove', function(e) {
            if (isPanning) {
              ${onPanUpdate != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onPanUpdate!)}');" : ''}
            }
          });
          
          el.addEventListener('mouseup', function(e) {
            if (isPanning) {
              isPanning = false;
              ${onPanEnd != null ? "window.__flartHandleClick('${FlartCallbackManager.register(onPanEnd!)}');" : ''}
            }
          });
        ''' : ''}
        
        // Mouse events
        ${onMouseDown != null ? "el.addEventListener('mousedown', () => window.__flartHandleClick('${FlartCallbackManager.register(onMouseDown!)}'));" : ''}
        ${onMouseUp != null ? "el.addEventListener('mouseup', () => window.__flartHandleClick('${FlartCallbackManager.register(onMouseUp!)}'));" : ''}
        ${onMouseMove != null ? "el.addEventListener('mousemove', () => window.__flartHandleClick('${FlartCallbackManager.register(onMouseMove!)}'));" : ''}

        // Context menu (right click)
        ${onContextMenu != null ? '''
          el.addEventListener('contextmenu', (e) => { 
            e.preventDefault(); 
            window.__flartHandleClick('${FlartCallbackManager.register(onContextMenu!)}'); 
          });
        ''' : ''}
        
        // Focus events
        ${onFocus != null ? "el.addEventListener('focus', () => window.__flartHandleClick('${FlartCallbackManager.register(onFocus!)}'));" : ''}
        ${onBlur != null ? "el.addEventListener('blur', () => window.__flartHandleClick('${FlartCallbackManager.register(onBlur!)}'));" : ''}
        
        // Scroll events
        ${onScroll != null ? "el.addEventListener('wheel', () => window.__flartHandleClick('${FlartCallbackManager.register(onScroll!)}'));" : ''}

        // Swipe Detection (Touch)
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
