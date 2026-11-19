import 'dart:async';
import '../../../flartdart.dart';

typedef ElevatedButton = FDElevatedButton;

class FDElevatedButton extends Widget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ButtonStyle? style;
  final bool autofocus;

  const FDElevatedButton({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.style,
    this.autofocus = false,
    super.key,
  });

  factory FDElevatedButton.icon({
    required VoidCallback? onPressed,
    required Widget icon,
    required Widget label,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ButtonStyle? style,
    bool autofocus = false,
    Key? key,
  }) {
    return FDElevatedButton(
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

    final bgColor = isEnabled
        ? (style?.backgroundColor?.toString() ?? theme.primaryColor.toString())
        : '#e2e8f0';

    final fgColor = isEnabled
        ? (style?.foregroundColor?.toString() ?? '#ffffff')
        : '#94a3b8';

    final elevation = style?.elevation ?? (isEnabled ? 2.0 : 0.0);
    final shadowStr = elevation > 0
        ? '0 ${elevation}px ${elevation * 2}px ${style?.shadowColor?.toString() ?? "rgba(0,0,0,0.18)"}'
        : 'none';

    final radius = style?.shape ?? BorderRadius.circular(6);
    final pad = style?.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
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
      'box-shadow': shadowStr,
      'cursor': isEnabled ? 'pointer' : 'not-allowed',
      'outline': 'none',
      'user-select': 'none',
      'transition': 'all 0.2s cubic-bezier(0.4, 0, 0.2, 1)',
      if (!isEnabled) 'opacity': '0.7',
      if (style?.minimumSize != null) 'min-width': '${style!.minimumSize!.width}px',
      if (style?.minimumSize != null) 'min-height': '${style!.minimumSize!.height}px',
      if (style?.fixedSize != null) 'width': '${style!.fixedSize!.width}px',
      if (style?.fixedSize != null) 'height': '${style!.fixedSize!.height}px',
    };

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
      },
      styles: styles,
      events: events.isNotEmpty ? events : null,
      children: [child.buildNode(context)],
    );
  }
}
