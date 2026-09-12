import 'dart:async';
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
  final String? rawCss;
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
    this.rawCss,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final id = 'btn_${key?.toString() ?? DateTime.now().microsecondsSinceEpoch}';

    final styles = <String, String>{
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

    final tapHandler = onPressed ?? onClick;
    if (tapHandler != null) events['click'] = (e) => tapHandler();
    if (onDoubleClick != null) events['dblclick'] = (e) => onDoubleClick!();

    if (onLongPress != null) {
      bool isLongPressCanceled = false;
      events['mousedown'] = (e) {
        isLongPressCanceled = false;
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!isLongPressCanceled) {
            onLongPress!();
          }
        });
      };
      events['mouseup'] = (e) => isLongPressCanceled = true;
      events['mouseleave'] = (e) => isLongPressCanceled = true;
    }

    if (onHover != null || onHoverEnter != null) {
      events['mouseenter'] = (e) {
        onHover?.call();
        onHoverEnter?.call();
      };
    }

    if (onHoverExit != null) events['mouseleave'] = (e) => onHoverExit!();

    if (onDragStart != null) events['dragstart'] = (e) => onDragStart!();
    if (onDrag != null) events['drag'] = (e) => onDrag!();
    if (onDragEnd != null) events['dragend'] = (e) => onDragEnd!();

    if (onFocus != null) events['focus'] = (e) => onFocus!();
    if (onBlur != null) events['blur'] = (e) => onBlur!();

    if (onContextMenu != null) {
      events['contextmenu'] = (e) {
        try {
          (e as dynamic).preventDefault();
        } catch (_) {}
        onContextMenu!();
      };
    }

    final attributes = <String, String>{};
    if (draggable) attributes['draggable'] = 'true';

    final FlartNode contentNode;
    if (child != null) {
      contentNode = child!.buildNode(context);
    } else {
      contentNode = FlartTextNode(text ?? label ?? 'Button');
    }

    return FlartElementNode(
      'button',
      id: id,
      attributes: attributes,
      styles: styles,
      events: events,
      children: [contentNode],
    );
  }
}
