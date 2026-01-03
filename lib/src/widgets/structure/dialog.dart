import 'dart:html';
import 'dart:async';
import '../../../flartdart.dart';

class Dialog extends Widget {
  final Widget? child;
  final FlartColor? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Alignment? alignment;

  Dialog({
    this.child,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = const EdgeInsets.all(40.0),
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
  });

  @override
  String render(BuildContext context) {
    final bgColor = backgroundColor?.toString() ?? '#ffffff';
    final pad = insetPadding ?? EdgeInsets.all(40.0);
    final padStyle =
        'padding: ${pad.top}px ${pad.right}px ${pad.bottom}px ${pad.left}px;';

    // Very basic rendering of the dialog container
    return '''
      <div style="
        background-color: $bgColor; 
        $padStyle
        border-radius: 4px; 
        box-shadow: 0 11px 15px -7px rgba(0,0,0,0.2), 0 24px 38px 3px rgba(0,0,0,0.14), 0 9px 46px 8px rgba(0,0,0,0.12);
        max-width: 80%;
        max-height: 80%;
        overflow: auto;
        display: flex;
        flex-direction: column;
        pointer-events: auto;
      ">
        ${child?.render(context) ?? ''}
      </div>
    ''';
  }
}

Future<T?> showDialog<T>({
  required Widget builder,
  bool barrierDismissible = true,
}) {
  final completer = Completer<T?>();

  final overlay = DivElement();
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
    overlay.onClick.listen((event) {
      if (event.target == overlay) {
        close();
      }
    });
  }

  // Render the dialog content
  final context = BuildContext(widget: builder);
  // Note: BuildContext usage here is a bit loose as it's not part of the main tree,
  // but for string generation it might be fine.

  final contentHtml = builder.render(context);
  overlay.setInnerHtml(contentHtml, treeSanitizer: NodeTreeSanitizer.trusted);

  // We need to attach event listeners to the rendered content if any.
  // Since Flart currently renders HTML strings, we lose the ability to attach events *inside* the render()
  // method for dynamically added content unless we re-hydrate or use delegated events.
  // For this "Readme aligned" version, we assume basic static rendering or that the framework
  // handles hygiene elsewhere.
  // However, `GestureDetector` works by attaching events to IDs or using global delegation.
  // Since this is a new root, we might need to notify the system.

  document.body?.append(overlay);

  return completer.future;
}
