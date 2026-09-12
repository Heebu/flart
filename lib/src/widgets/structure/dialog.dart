import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'dart:async';
import '../../../flartdart.dart';

class FDDialog extends Widget {
  final Widget? child;
  final FlartColor? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Alignment? alignment;
  final String? rawCss;

  const FDDialog({
    this.child,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = const EdgeInsets.all(40.0),
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.rawCss,
    super.key,
  });

  @override
  FlartNode buildNode(BuildContext context) {
    final bgColor = backgroundColor?.toString() ?? '#ffffff';
    final pad = insetPadding ?? const EdgeInsets.all(40.0);

    final styles = <String, String>{
      'background-color': bgColor,
      'padding': pad.toCss(),
      'border-radius': '4px',
      'box-shadow': '0 11px 15px -7px rgba(0,0,0,0.2), 0 24px 38px 3px rgba(0,0,0,0.14), 0 9px 46px 8px rgba(0,0,0,0.12)',
      'max-width': '80%',
      'max-height': '80%',
      'overflow': 'auto',
      'display': 'flex',
      'flex-direction': 'column',
      'pointer-events': 'auto',
      'box-sizing': 'border-box',
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

    return FlartElementNode(
      'div',
      id: key?.toString(),
      styles: styles,
      children: child != null ? [child!.buildNode(context)] : null,
    );
  }
}

Future<T?> showDialog<T>({
  required Widget builder,
  bool barrierDismissible = true,
}) {
  final completer = Completer<T?>();

  final overlay = web.document.createElement('div') as web.HTMLElement;
  overlay.style.position = 'fixed';
  overlay.style.top = '0';
  overlay.style.left = '0';
  overlay.style.width = '100vw';
  overlay.style.height = '100vh';
  overlay.style.backgroundColor = 'rgba(0, 0, 0, 0.54)';
  overlay.style.display = 'flex';
  overlay.style.alignItems = 'center';
  overlay.style.justifyContent = 'center';
  overlay.style.zIndex = '9999';

  void close([T? result]) {
    overlay.remove();
    if (!completer.isCompleted) {
      completer.complete(result);
    }
  }

  if (barrierDismissible) {
    overlay.addEventListener(
      'click',
      ((web.Event event) {
        if (event.target == overlay) {
          close();
        }
      }).toJS,
    );
  }

  final context = BuildContext(widget: builder);
  VDOMReconciler.reconcile(overlay, builder.buildNode(context));

  web.document.body?.append(overlay);

  return completer.future;
}
