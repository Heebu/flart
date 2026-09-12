import 'dart:async';
import 'dart:js_interop';
import 'package:flartdart/flartdart.dart';
import 'package:web/web.dart' as web;

class TestUtils {
  static web.HTMLDivElement? _testContainer;

  static web.HTMLDivElement get container {
    if (_testContainer == null) {
      _testContainer = web.document.createElement('div') as web.HTMLDivElement;
      _testContainer!.id = 'flart-test-container';
      web.document.body?.appendChild(_testContainer!);
    }
    return _testContainer!;
  }

  /// Mounts a widget into the DOM using VDOM reconciliation so that all
  /// lifecycle methods and event listeners are genuinely attached.
  /// Returns the root HTML element of the rendered widget.
  static web.Element mountWidget(Widget widget) {
    final c = container;
    // Clear container children between mounts
    while (c.firstChild != null) {
      c.removeChild(c.firstChild!);
    }

    resetRenderCounter();
    resetStateRegistry();

    final context = BuildContext(widget: widget);
    final vnode = widget.buildNode(context);

    VDOMReconciler.reconcile(c, vnode);

    return c.firstElementChild!;
  }

  /// Cleans up the DOM after a test.
  static void unmountWidget() {
    resetStateRegistry();
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

  /// Helper to query selector within the test container.
  static web.Element? querySelector(String selector) {
    return _testContainer?.querySelector(selector);
  }

  /// Helper to query all elements matching selector within test container.
  static List<web.Element> querySelectorAll(String selector) {
    if (_testContainer == null) return [];
    final list = _testContainer!.querySelectorAll(selector);
    final result = <web.Element>[];
    for (var i = 0; i < list.length; i++) {
      final item = list.item(i);
      if (item is web.Element) result.add(item);
    }
    return result;
  }

  /// Simulates a frame or timer advance.
  static Future<void> pump([dynamic durationOrMs = 20]) async {
    final duration = durationOrMs is Duration
        ? durationOrMs
        : Duration(milliseconds: (durationOrMs as num).toInt());
    await Future<void>.delayed(duration);
  }

  /// Dispatches a click event on the target element.
  static void click(web.Element element) {
    if (element is web.HTMLElement) {
      element.click();
    } else {
      element.dispatchEvent(web.MouseEvent('click', web.MouseEventInit(bubbles: true, cancelable: true)));
    }
  }

  /// Enters text into an HTML input element and triggers both input and change events.
  static void enterText(web.HTMLInputElement element, String text) {
    element.value = text;
    element.dispatchEvent(web.Event('input'));
    element.dispatchEvent(web.Event('change'));
  }

  /// Toggles a checkbox or radio input and fires change event.
  static void setChecked(web.HTMLInputElement element, bool checked) {
    if (element.checked != checked) {
      element.click();
    } else {
      element.checked = checked;
      element.dispatchEvent(web.Event('change'));
    }
  }
}
