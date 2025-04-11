import 'stateful_widget.dart';
import 'widget.dart';
import 'dart:html';


abstract class State<T extends StatefulWidget> {
  late T widget;

  void initState() {}
  void setState(void Function() fn) {
    fn();
    _rebuild(); // we define this private method below
  }

  void _rebuild() {
    // You can replace this logic with proper DOM diffing in future
    final html = build().render();
    final container = document.querySelector('#app');
    if (container != null) {
      container.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
    }
  }

  Widget build();
}
