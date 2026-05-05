import 'dart:js_interop';
import 'package:web/web.dart' as web;
import 'src/widgets/widget.dart';
import 'src/widgets/stateful_widget.dart' show resetRenderCounter;
import 'src/widgets/utils/build_context.dart';

Widget? _rootWidget;
web.Element? _appContainer;
web.HTMLElement? _overlayContainer;

void runApp(Widget rootWidget) {
  _rootWidget = rootWidget;

  _appContainer = web.document.querySelector('#output') ??
      web.document.querySelector('#app') ??
      web.document.body as web.Element?;

  _ensureOverlayContainer();
  // We no longer clear the entire head, as it removes the original style.css from index.html.

  _renderApp();

  print('Flart app initialized and rendered');
}

void _ensureOverlayContainer() {
  _overlayContainer =
      web.document.querySelector('#flart-overlay') as web.HTMLElement?;
  if (_overlayContainer == null) {
    final overlay = web.HTMLDivElement()
      ..id = 'flart-overlay';
    overlay.style.position = 'fixed';
    overlay.style.top = '0';
    overlay.style.left = '0';
    overlay.style.width = '100vw';
    overlay.style.height = '100vh';
    overlay.style.pointerEvents = 'none';
    overlay.style.zIndex = '9999';
    _overlayContainer = overlay;
    web.document.body?.append(overlay);
  }
}

void _renderApp() {
  if (_rootWidget == null || _appContainer == null) {
    print('Cannot render: root widget or app container is null');
    return;
  }

  // Reset the positional counter so StatefulWidget keys stay stable.
  resetRenderCounter();

  try {
    final context = BuildContext(widget: _rootWidget!);
    final html = _rootWidget!.render(context);

    _appContainer!.setHTMLUnsafe(html.toJS);

    _attachEventListeners();
  } catch (e, stack) {
    print('Error rendering app: $e\n$stack');
    _appContainer!.setHTMLUnsafe('''
      <div style="padding: 20px; color: red; font-family: sans-serif; background: #fff;">
        <h2>Flart Framework Error</h2>
        <p><strong>Message:</strong> $e</p>
        <pre style="overflow: auto; font-size: 12px; margin-top: 10px; background: #f5f5f5; padding: 10px;">$stack</pre>
      </div>
    '''.toJS);
  }
}

void _attachEventListeners() {
  // This will be called after each render to reattach event listeners
  // Event listeners are attached by individual widgets through their render methods
}

// Global re-render function for state updates
void reRenderApp() {
  print('Re-rendering app...');
  _renderApp();
}

void renderOverlays(List<dynamic> entries) {
  if (_overlayContainer == null || _rootWidget == null) return;

  final context = BuildContext(widget: _rootWidget!);
  final html = entries
      .map((entry) => (entry.builder(context) as Widget).render(context))
      .join();

  _overlayContainer!.setHTMLUnsafe(html.toJS);

  // Enable pointer events only if there are entries
  _overlayContainer!.style.pointerEvents =
      entries.isNotEmpty ? 'auto' : 'none';
}
