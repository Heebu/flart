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
  String _lastButtonPressed = 'None';
  int _buttonClickCount = 0;
  String _dropdownValue = 'Dart';
  double _sliderValue = 50.0;

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
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDWrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  FDElevatedButton(
                    onPressed: () {
                      setState(() {
                        _lastButtonPressed = 'Elevated Button';
                        _buttonClickCount++;
                      });
                    },
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
                  FDOutlinedButton(
                    onPressed: () {
                      setState(() {
                        _lastButtonPressed = 'Outlined Button';
                        _buttonClickCount++;
                      });
                    },
                    cssStyle: {
                      'padding': '12px 24px',
                      'border-radius': '8px',
                    },
                    child: FDText('Outlined Button',
                        style: TextStyle(color: FlartColor('#3b82f6'))),
                  ),
                  FDTextButton(
                    onPressed: () {
                      setState(() {
                        _lastButtonPressed = 'Text Button';
                        _buttonClickCount++;
                      });
                    },
                    child: FDText('Text Button',
                        style: TextStyle(color: FlartColor('#3b82f6'))),
                    cssStyle: {
                      'background-color': 'transparent',
                      'padding': '12px 24px',
                      'border': 'none',
                      'cursor': 'pointer',
                    },
                  ),
                  FDInkWell(
                    onTap: () {
                      setState(() {
                        _lastButtonPressed = 'InkWell Touch Area';
                        _buttonClickCount++;
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: FDContainer(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: FlartColor('#eff6ff'),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FDText('InkWell Touch Area',
                          style: TextStyle(color: FlartColor('#1d4ed8'))),
                    ),
                  ),
                ],
              ),
              FDSizedBox(height: 16),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: FlartColor('#f1f5f9'),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: FlartColor('#e2e8f0')),
                ),
                child: FDText(
                  'Last pressed: $_lastButtonPressed ($_buttonClickCount clicks)',
                  style: TextStyle(
                    fontSize: 14,
                    color: FlartColor('#3b82f6'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
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

        // Dropdown Showcase
        ShowcaseCard(
          title: 'FDDropdownButton',
          description: 'A dropdown menu to select an option from a list.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDDropdownButton<String>(
                value: _dropdownValue,
                items: const [
                  FDDropdownMenuItem(value: 'Dart', child: FDText('Dart')),
                  FDDropdownMenuItem(value: 'Flutter', child: FDText('Flutter')),
                  FDDropdownMenuItem(value: 'Flart', child: FDText('Flart')),
                  FDDropdownMenuItem(
                      value: 'Web', child: FDText('WebAssembly / JS')),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _dropdownValue = val;
                    });
                  }
                },
              ),
              FDSizedBox(height: 12),
              FDText(
                'Selected: $_dropdownValue',
                style: TextStyle(
                  color: FlartColor('#3b82f6'),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Slider Showcase
        ShowcaseCard(
          title: 'FDSlider',
          description: 'A slider to select a value from a continuous range.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDSlider(
                value: _sliderValue,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                activeColor: FlartColor('#3b82f6'),
                onChanged: (val) {
                  setState(() {
                    _sliderValue = val;
                  });
                },
              ),
              FDSizedBox(height: 12),
              FDText(
                'Slider Value: ${_sliderValue.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: FlartColor('#3b82f6'),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
