import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class InputShowcase extends StatefulWidget {
  @override
  State<InputShowcase> createState() => _InputShowcaseState();
}

class _InputShowcaseState extends State<InputShowcase> {
  String _textFieldValue = '';
  bool _isChecked1 = false;
  bool _isChecked2 = true;
  String _radioGroupValue = 'option1';

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDText(
          'Input Widgets',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: FlartColor('#0f172a'),
          ),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets to collect user input, like text fields, checkboxes, and buttons.',
          style: TextStyle(
            fontSize: 16,
            color: FlartColor('#64748b'),
          ),
        ),
        FDSizedBox(height: 32),

        // TextField Showcase
        ShowcaseCard(
          title: 'FDTextField',
          description:
              'A text input field for collecting short or long strings.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDTextField(
                placeholder: 'Enter some text...',
                initialValue: _textFieldValue,
                onChanged: (val) {
                  setState(() {
                    _textFieldValue = val;
                  });
                },
                cssStyle: {
                  'border': '1px solid #cbd5e1',
                  'border-radius': '8px',
                  'background-color': '#ffffff',
                },
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              FDSizedBox(height: 16),
              FDText(
                'You typed: $_textFieldValue',
                style: TextStyle(
                    color: FlartColor('#3b82f6'), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Buttons Showcase
        ShowcaseCard(
          title: 'Buttons',
          description: 'Various clickable buttons to trigger actions.',
          child: FDWrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FDElevatedButton(
                onPressed: () {},
                child: FDText('Elevated Button',
                    style: TextStyle(color: FlartColor('#ffffff'))),
                cssStyle: {
                  'background-color': '#3b82f6',
                  'padding': '12px 24px',
                  'border-radius': '8px',
                  'border': 'none',
                  'cursor': 'pointer',
                  'box-shadow':
                      '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
                },
              ),
              FDElevatedButton(
                onPressed: () {},
                child: FDText('Outlined Button',
                    style: TextStyle(color: FlartColor('#3b82f6'))),
                cssStyle: {
                  'background-color': 'transparent',
                  'padding': '12px 24px',
                  'border-radius': '8px',
                  'border': '2px solid #3b82f6',
                  'cursor': 'pointer',
                },
              ),
              FDTextButton(
                onPressed: () {},
                child: FDText('Text Button',
                    style: TextStyle(color: FlartColor('#3b82f6'))),
                cssStyle: {
                  'background-color': 'transparent',
                  'padding': '12px 24px',
                  'border': 'none',
                  'cursor': 'pointer',
                },
              ),
            ],
          ),
        ),

        // Checkbox Showcase
        ShowcaseCard(
          title: 'FDCheckbox',
          description: 'A checkbox for boolean state selection.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  FDCheckbox(
                    value: _isChecked1,
                    onChanged: (val) {
                      setState(() {
                        _isChecked1 = val;
                      });
                    },
                  ),
                  FDSizedBox(width: 8),
                  FDText('Unchecked by default'),
                ],
              ),
              FDSizedBox(height: 12),
              FDRow(
                children: [
                  FDCheckbox(
                    value: _isChecked2,
                    onChanged: (val) {
                      setState(() {
                        _isChecked2 = val;
                      });
                    },
                  ),
                  FDSizedBox(width: 8),
                  FDText('Checked by default'),
                ],
              ),
            ],
          ),
        ),

        // Radio Showcase
        ShowcaseCard(
          title: 'FDRadio',
          description:
              'Radio buttons for selecting a single option from a group.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  FDRadio<String>(
                    value: 'option1',
                    groupValue: _radioGroupValue,
                    onChanged: (val) {
                      setState(() => _radioGroupValue = val);
                    },
                  ),
                  FDSizedBox(width: 8),
                  FDText('Option 1'),
                ],
              ),
              FDSizedBox(height: 12),
              FDRow(
                children: [
                  FDRadio<String>(
                    value: 'option2',
                    groupValue: _radioGroupValue,
                    onChanged: (val) {
                      setState(() => _radioGroupValue = val);
                    },
                  ),
                  FDSizedBox(width: 8),
                  FDText('Option 2'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
