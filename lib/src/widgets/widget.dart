import '../foundation/key.dart';
import 'utils/build_context.dart';
import '../core/vdom/flart_node.dart';

abstract class Widget {
  final Key? key;
  const Widget({this.key});

  /// Legacy string-based rendering bridge for backwards compatibility.
  String render(BuildContext context) {
    try {
      return buildNode(context).toHtml();
    } on StackOverflowError {
      return '<div>Unimplemented render</div>';
    }
  }

  /// Virtual DOM representation.
  FlartNode buildNode(BuildContext context) {
    return FlartRawHtmlNode(render(context));
  }
}
