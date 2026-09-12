@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Input & Button Widgets', () {
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
          : root.querySelector('button') as web.HTMLElement;

      expect(pressed, isFalse);
      TestUtils.click(button);
      expect(pressed, isTrue);
      expect(button.textContent, contains('Click Me'));
    });

    test('FDOutlinedButton triggers onPressed and renders border', () {
      bool pressed = false;
      final widget = FDOutlinedButton(
        onPressed: () {
          pressed = true;
        },
        child: FDText('Outlined'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final button = root.tagName.toLowerCase() == 'button'
          ? root
          : root.querySelector('button') as web.HTMLElement;

      expect(button.style.border, contains('solid'));
      TestUtils.click(button);
      expect(pressed, isTrue);
    });

    test('FDTextButton triggers onPressed', () {
      bool pressed = false;
      final widget = FDTextButton(
        onPressed: () {
          pressed = true;
        },
        child: FDText('Text Button'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final button = root.tagName.toLowerCase() == 'button'
          ? root
          : root.querySelector('button') as web.HTMLElement;

      TestUtils.click(button);
      expect(pressed, isTrue);
    });

    test('FDInkWell triggers onTap and onHover', () {
      bool tapped = false;
      bool? hovered;
      final widget = FDInkWell(
        onTap: () {
          tapped = true;
        },
        onHover: (val) {
          hovered = val;
        },
        child: FDText('InkWell Content'),
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.textContent, contains('InkWell Content'));

      TestUtils.click(root);
      expect(tapped, isTrue);

      root.dispatchEvent(web.MouseEvent('mouseenter'));
      expect(hovered, isTrue);

      root.dispatchEvent(web.MouseEvent('mouseleave'));
      expect(hovered, isFalse);
    });

    test('FDTextField updates controller and triggers onChanged', () {
      final controller = TextEditingController(text: 'Initial');
      String? changedVal;

      final widget = FDTextField(
        controller: controller,
        placeholder: 'Enter name',
        onChanged: (val) {
          changedVal = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.querySelector('input') as web.HTMLInputElement?;
      expect(input, isNotNull);
      expect(input!.value, equals('Initial'));

      TestUtils.enterText(input, 'Updated Name');
      expect(controller.text, equals('Updated Name'));
      expect(changedVal, equals('Updated Name'));
    });

    test('TextArea updates controller and triggers onChanged', () {
      final controller = TextEditingController(text: 'Line 1');
      String? changed;

      final widget = TextArea(
        controller: controller,
        rows: 5,
        onChanged: (val) {
          changed = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final textarea = root.querySelector('textarea') as web.HTMLTextAreaElement?;
      expect(textarea, isNotNull);
      expect(textarea!.value, equals('Line 1'));

      textarea.value = 'Line 1\nLine 2';
      textarea.dispatchEvent(web.Event('input'));
      expect(controller.text, equals('Line 1\nLine 2'));
      expect(changed, equals('Line 1\nLine 2'));
    });

    test('FDCheckbox triggers onChanged when clicked', () {
      bool checked = false;
      final widget = FDCheckbox(
        value: checked,
        onChanged: (val) {
          checked = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.tagName.toLowerCase() == 'input'
          ? root as web.HTMLInputElement
          : root.querySelector('input') as web.HTMLInputElement;

      expect(input.checked, isFalse);
      TestUtils.setChecked(input, true);
      expect(checked, isTrue);
    });

    test('FDSwitch triggers onChanged when toggled', () {
      bool switched = false;
      final widget = FDSwitch(
        value: switched,
        onChanged: (val) {
          switched = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      expect(root.getAttribute('role'), equals('switch'));

      TestUtils.click(root);
      expect(switched, isTrue);
    });

    test('FDRadio triggers onChanged with selected value', () {
      String? selected;
      final widget = FDRadio<String>(
        value: 'option1',
        groupValue: selected,
        onChanged: (val) {
          selected = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.tagName.toLowerCase() == 'input'
          ? root as web.HTMLInputElement
          : root.querySelector('input') as web.HTMLInputElement;

      input.checked = true;
      input.dispatchEvent(web.Event('change'));
      expect(selected, equals('option1'));
    });

    test('FDDropdownButton triggers onChanged with selected item', () {
      String? selected = 'A';
      final widget = FDDropdownButton<String>(
        value: selected,
        items: [
          FDDropdownMenuItem(value: 'A', child: FDText('Option A')),
          FDDropdownMenuItem(value: 'B', child: FDText('Option B')),
        ],
        onChanged: (val) {
          selected = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final select = root.tagName.toLowerCase() == 'select'
          ? root as web.HTMLSelectElement
          : root.querySelector('select') as web.HTMLSelectElement;

      expect(select.value, equals('0')); // First item index

      select.value = '1';
      select.selectedIndex = 1;
      select.dispatchEvent(web.Event('change'));
      expect(selected, equals('B'));
    });

    test('FDSlider triggers onChanged when value is slid', () {
      double sliderVal = 20.0;
      final widget = FDSlider(
        value: sliderVal,
        min: 0,
        max: 100,
        onChanged: (val) {
          sliderVal = val;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.tagName.toLowerCase() == 'input'
          ? root as web.HTMLInputElement
          : root.querySelector('input') as web.HTMLInputElement;

      expect(double.parse(input.value), equals(20.0));

      input.value = '65.0';
      input.dispatchEvent(web.Event('input'));
      expect(sliderVal, equals(65.0));
    });

    test('FDDatePicker triggers onDateSelected on change', () {
      DateTime? pickedDate;
      final widget = FDDatePicker(
        initialDate: '2026-05-15',
        onDateSelected: (dt) {
          pickedDate = dt;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.tagName.toLowerCase() == 'input'
          ? root as web.HTMLInputElement
          : root.querySelector('input') as web.HTMLInputElement;

      expect(input.value, equals('2026-05-15'));

      input.value = '2026-06-20';
      input.dispatchEvent(web.Event('change'));
      input.dispatchEvent(web.Event('input'));
      expect(pickedDate, isNotNull);
      expect(pickedDate!.year, equals(2026));
      expect(pickedDate!.month, equals(6));
      expect(pickedDate!.day, equals(20));
    });

    test('ColorPicker triggers onChanged with new color', () {
      FlartColor? chosen;
      final widget = ColorPicker(
        initialColor: FlartColor('#ff0000'),
        onChanged: (color) {
          chosen = color;
        },
      );

      final root = TestUtils.mountWidget(widget) as web.HTMLElement;
      final input = root.querySelector('input') as web.HTMLInputElement?;
      expect(input, isNotNull);

      input!.value = '#00ff00';
      input.dispatchEvent(web.Event('input'));
      expect(chosen, isNotNull);
      expect(chosen!.hex, equals('#00ff00'));
    });
  });
}
