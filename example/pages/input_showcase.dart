import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class InputShowcasePage extends StatefulWidget {
  const InputShowcasePage({super.key});

  @override
  State<InputShowcasePage> createState() => _InputShowcasePageState();
}

class _InputShowcasePageState extends State<InputShowcasePage> {
  // Text Fields
  String _typedText = '';
  final TextEditingController _textController =
      TextEditingController(text: 'Hello Flart!');

  // Form State
  final GlobalKey<FDFormState> _formKey = GlobalKey<FDFormState>();
  String _formUsername = '';
  String _formStatus = 'Form not submitted';
  bool _formValid = false;

  // Selection Controls
  bool _checkboxVal1 = false;
  bool _checkboxVal2 = true;
  String _radioVal = 'standard';
  bool _switchVal = true;

  // Dropdown & Sliders
  String _dropdownVal = 'Flutter';
  double _sliderVal = 45.0;
  RangeValues _rangeVal = const RangeValues(20.0, 80.0);

  // Pickers
  DateTime? _selectedDate;
  String _selectedTime = '12:00';

  // Advanced Inputs
  String _textAreaVal = '';
  FlartColor _chosenColor = FlartColors.indigo;
  String _uploadedFiles = 'None';

  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        FDContainer(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: FlartColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const FlartColor('#e2e8f0')),
          ),
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  FDContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: FlartColors.teal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const FDText(
                      'CATEGORY 6',
                      style: TextStyle(
                        color: FlartColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const FDText(
                    'Input & Form Widgets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: FlartColor('#0f172a'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const FDText(
                'Comprehensive audit and refactor of input fields, form controllers, selection toggles, pickers, and advanced data-entry widgets following Flutter material specs without raw CSS.',
                style: TextStyle(fontSize: 14, color: FlartColor('#64748b')),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 1: Text Fields with InputDecoration
        ShowcaseCard(
          title: 'Text Fields & InputDecoration',
          description:
              'Material-style FDTextField with OutlineInputBorder, prefix/suffix icons, helper and error text styling.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDTextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'User Email Address',
                  hintText: 'name@example.com',
                  helperText: 'We will never share your email.',
                  prefixIcon: FDIcon(icon: FDIcons.email, size: 20),
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() => _typedText = val);
                },
              ),
              const SizedBox(height: 16),
              FDTextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Secure Password',
                  hintText: 'Enter at least 8 characters',
                  prefixIcon: FDIcon(icon: FDIcons.lock, size: 20),
                  suffixIcon: FDIcon(icon: FDIcons.visibility, size: 20),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              FDContainer(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const FlartColor('#f1f5f9'),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FDText(
                  'Live Controller Text: "${_textController.text}" (Typed: "$_typedText")',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: FlartColors.indigo),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 2: Form & FormField Validation
        ShowcaseCard(
          title: 'Form & TextFormField Validation',
          description:
              'FDForm and FDTextFormField integration with validator callbacks, form-level validation, and reset.',
          child: FDForm(
            key: _formKey,
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDTextFormField(
                  label: 'Account Username (Required, min 4 chars)',
                  placeholder: 'e.g. dev_flutter',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username cannot be empty';
                    }
                    if (value.trim().length < 4) {
                      return 'Username must be at least 4 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _formUsername = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                FDRow(
                  children: [
                    FDElevatedButton(
                      style: FDElevatedButton.styleFrom(
                        backgroundColor: FlartColors.teal,
                        foregroundColor: FlartColors.white,
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState?.validate() ?? false;
                        if (isValid) {
                          _formKey.currentState?.save();
                        }
                        setState(() {
                          _formValid = isValid;
                          _formStatus = isValid
                              ? 'Validated & Saved: $_formUsername'
                              : 'Validation Failed: Please fix errors above';
                        });
                      },
                      child: const FDText('Validate & Submit'),
                    ),
                    const SizedBox(width: 12),
                    FDOutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                        setState(() {
                          _formStatus = 'Form Reset';
                          _formValid = false;
                        });
                      },
                      child: const FDText('Reset Form'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FDContainer(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _formValid
                        ? const FlartColor('#dcfce7')
                        : const FlartColor('#fef2f2'),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _formValid
                          ? const FlartColor('#86efac')
                          : const FlartColor('#fca5a5'),
                    ),
                  ),
                  child: FDText(
                    _formStatus,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _formValid
                          ? const FlartColor('#166534')
                          : const FlartColor('#991b1b'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Card 3: Checkbox, Radio, and Switch
        ShowcaseCard(
          title: 'Selection Controls (Checkbox, Radio, Switch)',
          description:
              'Material toggles with active colors, disabled state support, and interactive event handling.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FDCheckbox(
                    value: _checkboxVal1,
                    onChanged: (val) {
                      setState(() => _checkboxVal1 = val ?? false);
                    },
                  ),
                  const SizedBox(width: 8),
                  const FDText('Receive Developer Newsletter'),
                  const SizedBox(width: 24),
                  FDCheckbox(
                    value: _checkboxVal2,
                    activeColor: FlartColors.teal,
                    onChanged: (val) {
                      setState(() => _checkboxVal2 = val ?? false);
                    },
                  ),
                  const SizedBox(width: 8),
                  const FDText('Accept Terms (Teal Active)'),
                ],
              ),
              const SizedBox(height: 16),
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FDText('Tier: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  FDRadio<String>(
                    value: 'standard',
                    groupValue: _radioVal,
                    onChanged: (val) {
                      if (val != null) setState(() => _radioVal = val);
                    },
                  ),
                  const SizedBox(width: 6),
                  const FDText('Standard'),
                  const SizedBox(width: 16),
                  FDRadio<String>(
                    value: 'pro',
                    groupValue: _radioVal,
                    activeColor: FlartColors.purple,
                    onChanged: (val) {
                      if (val != null) setState(() => _radioVal = val);
                    },
                  ),
                  const SizedBox(width: 6),
                  const FDText('Pro (Purple)'),
                ],
              ),
              const SizedBox(height: 16),
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FDSwitch(
                    value: _switchVal,
                    activeColor: FlartColors.indigo,
                    onChanged: (val) {
                      setState(() => _switchVal = val);
                    },
                  ),
                  const SizedBox(width: 12),
                  FDText('Realtime Push Notifications: ${_switchVal ? "ENABLED" : "DISABLED"}'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 4: Dropdown & Sliders
        ShowcaseCard(
          title: 'Dropdowns & Sliders',
          description:
              'FDDropdownButton selection menu and FDSlider range sliders with continuous/discrete adjustments.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  const FDText('Target Framework: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 12),
                  FDDropdownButton<String>(
                    value: _dropdownVal,
                    items: const [
                      FDDropdownMenuItem(
                          value: 'Flutter', child: FDText('Flutter Web')),
                      FDDropdownMenuItem(
                          value: 'Flart', child: FDText('Flart Pure Dart')),
                      FDDropdownMenuItem(
                          value: 'React', child: FDText('React / Next.js')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _dropdownVal = val);
                    },
                  ),
                  const SizedBox(width: 16),
                  FDText('Selected: $_dropdownVal',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              FDText('Volume / Scale: ${_sliderVal.toStringAsFixed(1)}%'),
              FDSlider(
                value: _sliderVal,
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: FlartColors.teal,
                onChanged: (val) {
                  setState(() => _sliderVal = val);
                },
              ),
              const SizedBox(height: 12),
              const FDText('Range Values Slider (Double Handle):'),
              RangePicker(
                min: 0,
                max: 100,
                startValue: _rangeVal.start,
                endValue: _rangeVal.end,
                onChanged: (vals) {
                  setState(() => _rangeVal = vals);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 5: Date & Time Pickers
        ShowcaseCard(
          title: 'Date & Time Pickers',
          description:
              'FDDatePicker and FDTimePicker inputs with ISO date/time conversions and callback triggers.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDRow(
                children: [
                  FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FDText('Pick a Date:',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      FDDatePicker(
                        initialDate: '2026-11-19',
                        onDateSelected: (date) {
                          setState(() => _selectedDate = date);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  FDColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FDText('Pick a Time:',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      FDTimePicker(
                        initialTime: _selectedTime,
                        onTimeSelected: (time) {
                          setState(() => _selectedTime = time);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FDText(
                'Selected Schedule: ${_selectedDate != null ? "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}" : "2026-11-19"} at $_selectedTime',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: FlartColors.indigo),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Card 6: Advanced Inputs (TextArea, ColorPicker, FileUpload)
        ShowcaseCard(
          title: 'Advanced Inputs (TextArea, Color, File)',
          description:
              'Multi-line text area with character counts, native HTML color picker, and file upload selector.',
          child: FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextArea(
                label: 'Project Release Notes',
                placeholder: 'Type changelog notes here...',
                rows: 3,
                maxLength: 200,
                onChanged: (val) {
                  setState(() => _textAreaVal = val);
                },
              ),
              if (_textAreaVal.isNotEmpty) ...[
                const SizedBox(height: 6),
                FDText('Preview (${_textAreaVal.length} chars): $_textAreaVal',
                    style: const TextStyle(fontSize: 12, color: FlartColors.grey)),
              ],
              const SizedBox(height: 16),
              FDRow(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ColorPicker(
                    label: 'Theme Accent Color',
                    initialColor: _chosenColor,
                    onChanged: (col) {
                      setState(() => _chosenColor = col);
                    },
                  ),
                  const SizedBox(width: 16),
                  FDContainer(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _chosenColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: FlartColors.grey),
                    ),
                  ),
                  const SizedBox(width: 32),
                  FileUpload(
                    label: 'Attach Project Files',
                    buttonText: 'Upload Document',
                    onChanged: (files) {
                      setState(() => _uploadedFiles = files.join(', '));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_uploadedFiles != 'None')
                FDText('Selected: $_uploadedFiles',
                    style: const TextStyle(
                        fontSize: 12, color: FlartColors.green)),
            ],
          ),
        ),
      ],
    );
  }
}
