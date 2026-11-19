import 'dart:async';
import '../../../flartdart.dart';

/// Generic button primitive in Flart without raw CSS.
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

  final ButtonStyle? style;
  final bool draggable;
  final bool autofocus;

  const FDButton({
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
    this.style,
    this.draggable = false,
    this.autofocus = false,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = context.theme;
    final tapHandler = onPressed ?? onClick;
    final isEnabled = tapHandler != null;

    final primary = theme.primaryColor;
    final bgColor = isEnabled
        ? (style?.backgroundColor?.toString() ?? primary.toString())
        : '#e2e8f0';

    final fgColor = isEnabled
        ? (style?.foregroundColor?.toString() ?? '#ffffff')
        : '#94a3b8';

    final pad = style?.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    final radius = style?.shape ?? BorderRadius.circular(6);
    final borderStr = style?.side?.toCss() ?? 'none';

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'box-sizing': 'border-box',
      'padding': pad.toCss(),
      'font-size': style?.textStyle?.fontSize != null ? '${style!.textStyle!.fontSize}px' : '14px',
      'font-weight': style?.textStyle?.fontWeight?.value ?? '500',
      'font-family': style?.textStyle?.fontFamily ?? 'inherit',
      'background-color': bgColor,
      'color': fgColor,
      'border': borderStr,
      'border-radius': radius.toCss(),
      'cursor': isEnabled ? 'pointer' : 'not-allowed',
      'outline': 'none',
      'user-select': 'none',
      'transition': 'all 0.2s cubic-bezier(0.4, 0, 0.2, 1)',
      if (!isEnabled) 'opacity': '0.7',
    };

    final events = <String, void Function(dynamic)>{};

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

    final attributes = <String, String>{
      'type': 'button',
      if (draggable) 'draggable': 'true',
      if (!isEnabled) 'disabled': '',
      if (autofocus) 'autofocus': '',
    };

    final FlartNode contentNode;
    if (child != null) {
      contentNode = child!.buildNode(context);
    } else {
      contentNode = FlartTextNode(text ?? label ?? 'Button');
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: attributes,
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [contentNode],
    );
  }
}
