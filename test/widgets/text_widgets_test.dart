@TestOn('browser')

import 'package:flartdart/flartdart.dart';
import 'package:test/test.dart';
import 'package:web/web.dart' as web;
import '../test_utils.dart';

void main() {
  group('Category 4: Text Widgets', () {
    tearDown(() {
      TestUtils.unmountWidget();
    });

    test('FDText renders with advanced typography and styling', () {
      final textWidget = FDText(
        'Flart Typography',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: FlartColor('#123456'),
          backgroundColor: FlartColor('#abcdef'),
          letterSpacing: 1.5,
          wordSpacing: 3.0,
          decoration: TextDecoration.underline,
          decorationColor: FlartColor('#ff0000'),
          decorationStyle: TextDecorationStyle.wavy,
          decorationThickness: 2.0,
        ),
      );

      final root = TestUtils.mountWidget(textWidget) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('span'));
      expect(root.textContent, equals('Flart Typography'));
      expect(root.style.fontSize, equals('20px'));
      expect(root.style.fontWeight, equals('700'));
      expect(root.style.fontStyle, equals('italic'));
      expect(root.style.letterSpacing, equals('1.5px'));
      expect(root.style.wordSpacing, equals('3px'));
      expect(root.style.getPropertyValue('text-decoration-line'),
          contains('underline'));
      expect(
          root.style.getPropertyValue('text-decoration-style'), equals('wavy'));
    });

    test('FDText handles overflow and maxLines with line clamping', () {
      final clampedText = FDText(
        'This is a long sentence that should truncate with ellipsis after two lines.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

      final root = TestUtils.mountWidget(clampedText) as web.HTMLElement;
      expect(root.style.overflow, equals('hidden'));
      expect(root.style.textOverflow, equals('ellipsis'));
      expect(root.style.display, equals('-webkit-box'));
      expect(root.style.getPropertyValue('-webkit-line-clamp'), equals('2'));
    });

    test('TextStyle.copyWith correctly merges and preserves styles', () {
      final base = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: FlartColor('#111111'),
      );
      final derived = base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      );

      expect(base.fontSize, equals(16));
      expect(base.fontWeight, equals(FontWeight.normal));
      expect(base.fontStyle, isNull);

      expect(derived.fontSize, equals(24));
      expect(derived.fontWeight, equals(FontWeight.bold));
      expect(derived.fontStyle, equals(FontStyle.italic));
      expect(derived.color, equals(FlartColor('#111111')));
    });

    test('TextDecoration.combine and multi-line decorations', () {
      final combined = TextDecoration.combine([
        TextDecoration.underline,
        TextDecoration.lineThrough,
      ]);
      expect(combined.contains(TextDecoration.underline), isTrue);
      expect(combined.contains(TextDecoration.lineThrough), isTrue);
      expect(combined.contains(TextDecoration.overline), isFalse);

      final style = TextStyle(decoration: combined);
      final css = style.toCss();
      expect(css['text-decoration-line'], equals('underline line-through'));
    });

    test('FDText.rich renders nested TextSpans and handles click callbacks',
        () {
      var clicked = false;
      final richWidget = FDText.rich(
        TextSpan(
          text: 'Prefix ',
          style: TextStyle(color: FlartColor('#000000')),
          children: [
            TextSpan(
              text: 'Clickable Link',
              style: TextStyle(
                color: FlartColor('#0000ff'),
                decoration: TextDecoration.underline,
              ),
              onTap: () {
                clicked = true;
              },
            ),
            TextSpan(text: ' Suffix'),
          ],
        ),
      );

      final root = TestUtils.mountWidget(richWidget) as web.HTMLElement;
      expect(root.textContent, equals('Prefix Clickable Link Suffix'));

      final spans = root.getElementsByTagName('span');
      expect(spans.length, greaterThanOrEqualTo(2));

      // Second span is the clickable one
      final linkSpan = spans.item(1) as web.HTMLElement;
      expect(linkSpan.textContent, equals('Clickable Link'));
      expect(linkSpan.style.cursor, equals('pointer'));

      linkSpan.dispatchEvent(web.MouseEvent('click'));
      expect(clicked, isTrue);
    });

    test('FDSelectableText allows user text selection', () {
      final selectable = FDSelectableText(
        'Selectable and copyable content',
        style: TextStyle(fontSize: 16),
      );

      final root = TestUtils.mountWidget(selectable) as web.HTMLElement;
      expect(root.textContent, equals('Selectable and copyable content'));
      expect(root.style.userSelect, equals('text'));
      expect(root.style.cursor, equals('text'));
    });

    test('FDLinkText renders external link and triggers callback', () {
      var pressed = false;
      final link = FDLinkText(
        text: 'Visit Google',
        url: 'https://google.com',
        onPressed: () {
          pressed = true;
        },
      );

      final root = TestUtils.mountWidget(link) as web.HTMLElement;
      expect(root.tagName.toLowerCase(), equals('a'));
      expect((root as web.HTMLAnchorElement).href, contains('google.com'));
      expect(root.textContent, equals('Visit Google'));
      expect(root.style.textDecoration, contains('underline'));

      root.dispatchEvent(web.MouseEvent('click'));
      expect(pressed, isTrue);
    });

    test('FDEditableText renders input and updates controller on input event',
        () {
      final controller = TextEditingController(text: 'Initial text');
      String? changedValue;

      final editable = FDEditableText(
        controller: controller,
        placeholder: 'Enter text here',
        onChanged: (val) {
          changedValue = val;
        },
      );

      final root = TestUtils.mountWidget(editable) as web.HTMLElement;
      final input = root.querySelector('input') as web.HTMLInputElement?;
      expect(input, isNotNull);
      expect(input!.value, equals('Initial text'));
      expect(input.placeholder, equals('Enter text here'));

      // Simulate input event
      input.value = 'Updated text';
      input.dispatchEvent(web.Event('input'));

      expect(controller.text, equals('Updated text'));
      expect(changedValue, equals('Updated text'));
    });

    test('FDEditableText renders multiline textarea when maxLines > 1', () {
      final controller = TextEditingController(text: 'Multiline\nContent');
      final editable = FDEditableText(
        controller: controller,
        maxLines: 4,
        keyboardType: TextInputType.multiline,
      );

      final root = TestUtils.mountWidget(editable) as web.HTMLElement;
      final textarea =
          root.querySelector('textarea') as web.HTMLTextAreaElement?;
      expect(textarea, isNotNull);
      expect(textarea!.rows, equals(4));
      expect(textarea.value, equals('Multiline\nContent'));
    });
  });
}
