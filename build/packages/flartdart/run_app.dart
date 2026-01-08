import 'dart:html';
import 'src/widgets/widget.dart';
import 'src/widgets/utils/build_context.dart';

Widget? _rootWidget;
Element? _appContainer;

void runApp(Widget rootWidget) {
  _rootWidget = rootWidget;

  _appContainer = document.querySelector('#output') ??
      document.querySelector('#app') ??
      document.body;

  _renderApp();

  print('Flart app initialized and rendered');
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

    print('App rendered successfully');
  } catch (e) {
    print('Error rendering app: $e');
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
