import 'dart:async';
import 'dart:html';
import '../../../flartdart.dart';

class FDButton extends Widget {
  final String? text;
  final String? label;
  final Widget? child;

  // Click events
  final VoidCallback? onPressed;
  final VoidCallback? onClick; // alias
  final VoidCallback? onDoubleClick;
  final VoidCallback? onLongPress;

  // Hover events
  final VoidCallback? onHover;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;

  // Drag events
  final VoidCallback? onDragStart;
  final VoidCallback? onDrag;
  final VoidCallback? onDragEnd;

  // Focus events
  final VoidCallback? onFocus;
  final VoidCallback? onBlur;

  // Right click
  final VoidCallback? onContextMenu;

  final Map<String, String>? cssStyle;
  final bool draggable;

  FDButton({
    this.text,
    this.label,
    this.child,
    this.onPressed,
    this.onClick,
    this.onDoubleClick,
    this.onLongPress,
    this.onHover,
    this.onHoverEnter,
    this.onHoverExit,
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
    this.onFocus,
    this.onBlur,
    this.onContextMenu,
    this.cssStyle,
    this.draggable = false,
  });

  @override
  String render(BuildContext context) {
    final id = 'btn-${DateTime.now().microsecondsSinceEpoch}';
    final styles = _styleToString(cssStyle);

    Future.delayed(Duration.zero, () {
      final el = document.querySelector('#$id');
      if (el != null) {
        // Click events
        final tapHandler = onPressed ?? onClick;
        if (tapHandler != null) {
          el.onClick.listen((_) => tapHandler());
        }

        // Double click
        if (onDoubleClick != null) {
          el.onDoubleClick.listen((_) => onDoubleClick!());
        }

        // Long press
        if (onLongPress != null) {
          Timer? longPressTimer;
          el.onMouseDown.listen((_) {
            longPressTimer = Timer(Duration(milliseconds: 600), () {
              onLongPress!();
            });
          });
          el.onMouseUp.listen((_) => longPressTimer?.cancel());
          el.onMouseLeave.listen((_) => longPressTimer?.cancel());
        }

        // Hover events
        if (onHover != null || onHoverEnter != null) {
          el.onMouseEnter.listen((_) {
            onHover?.call();
            onHoverEnter?.call();
          });
        }

        if (onHoverExit != null) {
          el.onMouseLeave.listen((_) => onHoverExit!());
        }

        // Drag events
        if (onDragStart != null) {
          el.onDragStart.listen((_) => onDragStart!());
        }

        if (onDrag != null) {
          el.onDrag.listen((_) => onDrag!());
        }

        if (onDragEnd != null) {
          el.onDragEnd.listen((_) => onDragEnd!());
        }

        // Focus events
        if (onFocus != null) {
          el.onFocus.listen((_) => onFocus!());
        }

        if (onBlur != null) {
          el.onBlur.listen((_) => onBlur!());
        }

        // Context menu (right click)
        if (onContextMenu != null) {
          el.onContextMenu.listen((e) {
            e.preventDefault();
            onContextMenu!();
          });
        }
      }
    });

    final content = child?.render(context) ?? (text ?? label ?? 'Button');

    return '<button id="$id" style="$styles" ${draggable ? 'draggable="true"' : ''}">$content</button>';
  }

  String _styleToString(Map<String, String>? styles) {
    if (styles == null) return '';
    return styles.entries.map((e) => '${e.key}:${e.value}').join(';');
  }
}





