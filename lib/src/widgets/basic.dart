import 'dart:html';

import '../framework.dart';

class Text extends StatelessWidget {
  final String text;

  Text(this.text);

  @override
  Widget build() {
    return RawHtmlWidget('span', text: text);
  }
}

class RawHtmlWidget extends Widget {
  final String tag;
  final String? text;

  RawHtmlWidget(this.tag, {this.text});

  @override
  Element createElement() {
    final element = document.createElement(tag);
    if (text != null) {
      element.text = text;
    }
    return element;
  }
}
