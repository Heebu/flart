import 'package:flartdart/flartdart.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';

class TestUtils {
  static web.HTMLDivElement? _testContainer;

  /// Mounts a widget into the DOM for testing.
  /// Returns the root HTML element of the rendered widget.
  static web.Element mountWidget(Widget widget) {
    if (_testContainer == null) {
      _testContainer = web.document.createElement('div') as web.HTMLDivElement;
      _testContainer!.id = 'flart-test-container';
      web.document.body?.appendChild(_testContainer!);
    }

    // Create a dummy context for rendering
    final context = BuildContext(widget: widget);

    // Render the HTML string
    final htmlString = widget.render(context);

    // Inject into the DOM
    _testContainer!.setHTMLUnsafe(htmlString.toJS);

    // Call attach logic for widgets that need it
    if (widget is StatefulWidget) {
      // In a real framework test harness we'd properly manage State lifecycle,
      // but for basic headless testing, rendering HTML is often enough.
      // If we need to attach event listeners, we might need a way to mock `runApp` entirely.
    }

    // Return the first child element of the container, which should be the root of the widget
    return _testContainer!.firstElementChild!;
  }

  /// Cleans up the DOM after a test.
  static void unmountWidget() {
    if (_testContainer != null) {
      _testContainer!.innerHTML = ''.toJS as JSAny;
      _testContainer!.remove();
      _testContainer = null;
    }
  }

  /// Helper to get an element by its ID within the test container.
  static web.Element? getElementById(String id) {
    return web.document.getElementById(id);
  }
}
