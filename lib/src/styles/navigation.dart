import '../../flart.dart';
import 'dart:html';

abstract class FlartPage extends Widget {
  const FlartPage();
}

class Navigator {
  static final List<FlartPage> _stack = [];

  static FlartPage get current => _stack.isNotEmpty ? _stack.last : const _EmptyPage();

  static void push(FlartPage page) {
    _stack.add(page);
    _refresh(withTransition: true);
  }

  static void pop() {
    if (_stack.length > 1) {
      _stack.removeLast();
      _refresh(withTransition: true);
    }
  }

  static void replace(FlartPage page) {
    if (_stack.isNotEmpty) _stack.removeLast();
    _stack.add(page);
    _refresh(withTransition: false);
  }

  static void _refresh({bool withTransition = false}) {
    final html = current.render();

    final app = querySelector('#app');
    if (app != null) {
      if (withTransition) {
        app.classes.add('fade-out');
        Future.delayed(Duration(milliseconds: 300), () {
          app.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
          app.classes.remove('fade-out');
          app.classes.add('fade-in');
        });
      } else {
        app.setInnerHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
      }
    }
  }
}

class _EmptyPage extends FlartPage {
  const _EmptyPage();

  @override
  String render() => '<div>No route defined</div>';
}
