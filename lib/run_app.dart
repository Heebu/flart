import 'dart:html';
import 'src/widgets/widget.dart';
import 'src/widgets/utils/build_context.dart';

void runApp(Widget rootWidget) {
  final context = BuildContext(widget: rootWidget);
  final html = rootWidget.render(context);
  (document.querySelector('#app') ?? document.body)
      ?.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
}

