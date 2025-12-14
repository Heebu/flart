import 'dart:html';
import 'src/widgets/widget.dart';
import 'src/widgets/utils/build_context.dart';

Widget? _rootWidget;

void runApp(Widget rootWidget) {
  _rootWidget = rootWidget;
  _renderApp();
}

void _renderApp() {
  if (_rootWidget == null) return;
  final context = BuildContext(widget: _rootWidget!);
  final html = _rootWidget!.render(context);
  (document.querySelector('#app') ?? document.body)
      ?.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
}

// Global re-render function
void reRenderApp() {
  _renderApp();
}

