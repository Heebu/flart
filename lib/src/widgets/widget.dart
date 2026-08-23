import '../foundation/key.dart';
import 'utils/build_context.dart';
import '../core/vdom/flart_node.dart';

abstract class Widget {
  final Key? key;
  const Widget({this.key});

  /// Legacy string-based rendering.
  /// This now acts as a bridge for backwards compatibility: 
  /// if a legacy widget calls .render() on a VDOM-migrated child, 
  /// the child will serialize its VDOM node back to an HTML string.
  String render(BuildContext context) {
    // We try to call buildNode. If the subclass hasn't overridden it,
    // buildNode will call FlartRawHtmlNode(render(context)).
    // To prevent infinite recursion if a widget overrides NEITHER, 
    // we use a safe fallback. However, since all widgets previously 
    // overrode render(), this should safely bridge VDOM -> String.
    try {
      return buildNode(context).toHtml();
    } on StackOverflowError {
      return '<div>Unimplemented render</div>';
    }
  }

  /// Virtual DOM representation.
  /// Defaults to wrapping [render] in a raw HTML node for progressive migration.
  FlartNode buildNode(BuildContext context) {
    return FlartRawHtmlNode(render(context));
  }
}
