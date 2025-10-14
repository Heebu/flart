import 'utils/build_context.dart';

abstract class Widget {
  const Widget();
  /// Render returns an HTML (or virtual DOM) string representation.
  String render(BuildContext context);
}


