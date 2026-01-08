import 'dart:async';
import 'dart:html' as html;
import '../../../flartdart.dart';

class FDGestureDetector extends Widget {
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
  final String? rawCss;

  FDGestureDetector({
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
  });

  @override
  String render(BuildContext context) {
    final id = 'gesture_${DateTime.now().microsecondsSinceEpoch}';

    // Schedule listener attachment after render
    Future.delayed(Duration.zero, () {
      final el = html.document.getElementById(id);
      if (el == null) return;

      // Tap events
      if (onTap != null) el.onClick.listen((_) => onTap!());
      if (onDoubleTap != null) el.onDoubleClick.listen((_) => onDoubleTap!());
      if (onTapDown != null) el.onMouseDown.listen((_) => onTapDown!());
      if (onTapUp != null) el.onMouseUp.listen((_) => onTapUp!());

      // Long press
      if (onLongPress != null) {
        Timer? longPressTimer;
        el.onMouseDown.listen((_) {
          longPressTimer = Timer(Duration(milliseconds: 700), () {
            onLongPress!();
          });
        });
        el.onMouseUp.listen((_) => longPressTimer?.cancel());
        el.onMouseLeave.listen((_) => longPressTimer?.cancel());
      }

      // Hover events
      if (onHover != null || onHoverEnter != null) {
        el.onMouseEnter.listen((_) {
          if (onHover != null) onHover!();
          if (onHoverEnter != null) onHoverEnter!();
        });
      }
      if (onHoverExit != null) el.onMouseLeave.listen((_) => onHoverExit!());

      // Pan/Drag events
      if (onPanStart != null || onPanUpdate != null || onPanEnd != null) {
        bool isPanning = false;
        el.onMouseDown.listen((e) {
          isPanning = true;
          if (onPanStart != null) onPanStart!();
        });

        // Listen on window to catch drags outside element
        html.window.onMouseMove.listen((e) {
          if (isPanning && onPanUpdate != null) onPanUpdate!();
        });

        html.window.onMouseUp.listen((e) {
          if (isPanning) {
            isPanning = false;
            if (onPanEnd != null) onPanEnd!();
          }
        });
      }

      // Mouse events
      if (onMouseDown != null) el.onMouseDown.listen((_) => onMouseDown!());
      if (onMouseUp != null) el.onMouseUp.listen((_) => onMouseUp!());
      if (onMouseMove != null) el.onMouseMove.listen((_) => onMouseMove!());

      // Context menu
      if (onContextMenu != null) {
        el.onContextMenu.listen((e) {
          e.preventDefault();
          onContextMenu!();
        });
      }

      // Focus
      if (onFocus != null) el.onFocus.listen((_) => onFocus!());
      if (onBlur != null) el.onBlur.listen((_) => onBlur!());

      // Scroll
      if (onScroll != null) el.onMouseWheel.listen((_) => onScroll!());

      // Swipe Detection
      if (onSwipeLeft != null ||
          onSwipeRight != null ||
          onSwipeUp != null ||
          onSwipeDown != null) {
        num startX = 0;
        num startY = 0;

        el.onTouchStart.listen((e) {
          if (e.touches!.isNotEmpty) {
            startX = e.touches![0].client.x;
            startY = e.touches![0].client.y;
          }
        });

        el.onTouchEnd.listen((e) {
          if (e.changedTouches!.isNotEmpty) {
            final dx = e.changedTouches![0].client.x - startX;
            final dy = e.changedTouches![0].client.y - startY;
            final absDx = dx.abs();
            final absDy = dy.abs();

            if (absDx > absDy && absDx > 30) {
              if (dx > 0) {
                if (onSwipeRight != null) onSwipeRight!();
              } else {
                if (onSwipeLeft != null) onSwipeLeft!();
              }
            } else if (absDy > absDx && absDy > 30) {
              if (dy > 0) {
                if (onSwipeDown != null) onSwipeDown!();
              } else {
                if (onSwipeUp != null) onSwipeUp!();
              }
            }
          }
        });
      }
    });

    return '<div id="$id" tabindex="0" style="outline: none; display: inherit; ${rawCss ?? ''}">${child.render(context)}</div>';
  }
}
