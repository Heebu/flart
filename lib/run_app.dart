import 'dart:html';
import 'src/widgets/widget.dart';

void runApp(Widget rootWidget) {
  final html = rootWidget.render();
  document.body?.setInnerHtml(
    html,
    treeSanitizer: NodeTreeSanitizer.trusted,
  );
}
