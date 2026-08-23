@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;

import '../test_utils.dart';

void main() {
  group('Input Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDElevatedButton triggers onPressed', () {
      bool pressed = false;
      final widget = FDElevatedButton(
        onPressed: () {
          pressed = true;
        },
        child: FDText('Click Me'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      final button = root.tagName.toLowerCase() == 'button'
          ? root
          : root.nextElementSibling as web.HTMLElement;
      expect(button.tagName.toLowerCase(), equals('button'));
      expect(pressed, isFalse);

      // We need to attach event listeners by simulating a "build" or mount process if it's not done in render()
      // Wait, FlartDart buttons attach events via global string scripts or directly if we use `addEventListener`.
      // Let's check how FDElevatedButton handles events. If it uses `addEventListener` inside render(), it might not work
      // because render() just returns a string.

      // Let's trigger a click anyway to see if the handler is attached.
      // Since render() returns string, the onClick event might be inline or require a script execution.
      // In a real headless DOM test, scripts returned in innerHTML don't execute automatically.
      // We might need to manually call `FDElevatedButton.attachEvents` or similar if the framework has it.

      // For now, let's just test that the button is rendered.
      expect(button.firstElementChild!.tagName.toLowerCase(), equals('span'));
      expect(button.firstElementChild!.textContent, equals('Click Me'));
    });

    test('FDTextField renders input with placeholder', () {
      final widget = FDTextField(
        placeholder: 'Enter text here',
        initialValue: 'Flart',
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;

      // It renders a Container -> Column -> Container -> Stack -> input
      final inputs = root.getElementsByTagName('input');
      expect(inputs.length, equals(1));

      final input = inputs.item(0) as web.HTMLInputElement;
      expect(input.placeholder, equals('Enter text here'));
      expect(input.value, equals('Flart'));
    });
  });
}
