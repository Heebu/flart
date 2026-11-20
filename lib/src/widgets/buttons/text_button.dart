import 'dart:async';
import '../../../flartdart.dart';

typedef TextButton = FDTextButton;

class FDTextButton extends Widget {
  final Widget? child;
  final String? label;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ButtonStyle? style;
  final bool autofocus;

  const FDTextButton({
    this.child,
    this.label,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.style,
    this.autofocus = false,
    super.key,
  });

  factory FDTextButton.icon({
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ButtonStyle? style,
    bool autofocus = false,
    Key? key,
  }) {
    return FDTextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      style: style,
      autofocus: autofocus,
      key: key,
      child: FDRow(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const FDSizedBox(width: 8),
          label,
        ],
      ),
    );
  }

  static ButtonStyle styleFrom({
    TextStyle? textStyle,
    FlartColor? backgroundColor,
    FlartColor? foregroundColor,
    FlartColor? overlayColor,
    FlartColor? shadowColor,
    double? elevation,
    EdgeInsets? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    BorderRadius? shape,
    Alignment? alignment,
  }) {
    return ButtonStyle.styleFrom(
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: shadowColor,
      elevation: elevation,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      alignment: alignment,
    );
  }

  @override
  FlartNode buildNode(BuildContext context) {
    final theme = context.theme;
    final isEnabled = onPressed != null;

    final primary = theme.primaryColor;
    final fgColor = isEnabled
        ? (style?.foregroundColor?.toString() ?? primary.toString())
        : '#94a3b8';

    final bgColor = isEnabled
        ? (style?.backgroundColor?.toString() ?? 'transparent')
        : 'transparent';

    final radius = style?.shape ?? BorderRadius.circular(6);
    final pad = style?.padding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final borderStr = style?.side?.toCss() ?? 'none';

    final styles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'box-sizing': 'border-box',
      'padding': pad.toCss(),
      'font-size': style?.textStyle?.fontSize != null
          ? '${style!.textStyle!.fontSize}px'
          : '14px',
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
      if (!isEnabled) 'opacity': '0.5',
      if (style?.minimumSize != null)
        'min-width': '${style!.minimumSize!.width}px',
      if (style?.minimumSize != null)
        'min-height': '${style!.minimumSize!.height}px',
      if (style?.fixedSize != null) 'width': '${style!.fixedSize!.width}px',
      if (style?.fixedSize != null) 'height': '${style!.fixedSize!.height}px',
    };

    final children = <FlartNode>[];
    if (child != null) {
      children.add(child!.buildNode(context));
    } else if (label != null) {
      children.add(FlartTextNode(label!));
    }

    final events = <String, void Function(dynamic)>{};
    if (isEnabled) {
      events['click'] = (e) => onPressed!();
      if (onHover != null) {
        events['mouseenter'] = (_) => onHover!(true);
        events['mouseleave'] = (_) => onHover!(false);
      }
      if (onLongPress != null) {
        bool isCanceled = false;
        events['mousedown'] = (_) {
          isCanceled = false;
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!isCanceled) onLongPress!();
          });
        };
        events['mouseup'] = (_) => isCanceled = true;
        events['mouseleave'] = (_) => isCanceled = true;
      }
    }

    return FlartElementNode(
      'button',
      id: key?.toString(),
      attributes: {
        'type': 'button',
        if (!isEnabled) 'disabled': '',
        if (autofocus) 'autofocus': '',
        'class': 'flart-text-button',
      },
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: children,
    );
  }
}
