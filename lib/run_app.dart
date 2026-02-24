import 'dart:html';
import 'src/widgets/widget.dart';
import 'src/widgets/utils/build_context.dart';

Widget? _rootWidget;
Element? _appContainer;
Element? _overlayContainer;

void runApp(Widget rootWidget) {
  _rootWidget = rootWidget;

  _appContainer = document.querySelector('#output') ??
      document.querySelector('#app') ??
      document.body;

  _ensureOverlayContainer();
  // We no longer clear the entire head, as it removes the original style.css from index.html.

  _renderApp();

  print('Flart app initialized and rendered');
}

void _ensureOverlayContainer() {
  _overlayContainer = document.querySelector('#flart-overlay');
  if (_overlayContainer == null) {
    _overlayContainer = document.createElement('div')
      ..id = 'flart-overlay'
      ..style.position = 'fixed'
      ..style.top = '0'
      ..style.left = '0'
      ..style.width = '100vw'
      ..style.height = '100vh'
      ..style.pointerEvents = 'none'
      ..style.zIndex = '9999';
    document.body?.append(_overlayContainer!);
  }
}

void _renderApp() {
  if (_rootWidget == null || _appContainer == null) {
    print('Cannot render: root widget or FDContainer is null');
    return;
  }

  try {
    final context = BuildContext(widget: _rootWidget!);
    final html = _rootWidget!.render(context);

    _appContainer!.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);

    _attachEventListeners();
  } catch (e, stack) {
    print('Error rendering app: $e\n$stack');
    _appContainer!.setInnerHtml('''
      <div style="padding: 20px; color: red; font-family: sans-serif; background: #fff;">
        <h2>Flart Framework Error</h2>
        <p><strong>Message:</strong> $e</p>
        <pre style="overflow: auto; font-size: 12px; margin-top: 10px; background: #f5f5f5; padding: 10px;">$stack</pre>
      </div>
    ''', treeSanitizer: NodeTreeSanitizer.trusted);
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

  _overlayContainer!
      .setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);

  // Enable pointer events only if there are entries
  _overlayContainer!.style.pointerEvents = entries.isNotEmpty ? 'auto' : 'none';
}
