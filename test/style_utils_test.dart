import 'package:flartdart/src/helper/style_utils.dart';
import 'package:test/test.dart';

void main() {
  group('toInlineStyle', () {
    test('serializes declarations', () {
      final style = toInlineStyle(<String, String>{
        'display': 'flex',
        'padding': '8px',
      });

      expect(style, contains('display: flex;'));
      expect(style, contains('padding: 8px;'));
    });

    test('appends raw css when provided', () {
      final style = toInlineStyle(
        <String, String>{'display': 'block'},
        rawCss: 'border: 1px solid red;',
      );

      expect(style, contains('display: block;'));
      expect(style, contains('border: 1px solid red;'));
    });

    test('skips empty keys and values', () {
      final style = toInlineStyle(<String, String>{
        '': 'value',
        'width': '',
        'height': '100px',
      });

      expect(style, isNot(contains(': value;')));
      expect(style, isNot(contains('width: ;')));
      expect(style, contains('height: 100px;'));
    });
  });
}
