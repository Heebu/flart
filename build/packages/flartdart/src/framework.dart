
import 'dart:html';

abstract class Widget {
  Element createElement();
}

abstract class StatelessWidget extends Widget {
  @override
  Element createElement() {
    final component = build();
    return component.createElement();
  }

  Widget build();
}

