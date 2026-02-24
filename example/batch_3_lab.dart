import 'package:flartdart/flartdart.dart';

class Batch3Lab extends StatefulWidget {
  const Batch3Lab({Key? key}) : super(key: key);

  @override
  State<Batch3Lab> createState() => _Batch3LabState();
}

class _Batch3LabState extends State<Batch3Lab> {
  bool _checkboxVal = false;
  bool _switchVal = true;
  int _radioVal = 1;
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Batch 3: Interactive Inputs')),
      body: FDListView(
        padding: EdgeInsets.all(24),
        children: [
          _sectionTitle('1. Text Input & Focus'),
          FDTextField(
            label: 'User Identification',
            placeholder: 'Enter your alias...',
            helperText: 'Visible only to teammates',
            prefixIcon: FDIcon(icon: FDIcons.person, size: 20),
            onChanged: (val) => setState(() => _inputText = val),
          ),
          FDSizedBox(height: 16),
          FDTextField(
            label: 'Secure Password',
            placeholder: 'Min 8 characters',
            obscureText: true,
            prefixIcon: FDIcon(icon: FDIcons.lock, size: 20),
            errorText: _inputText.length < 3 ? 'Alias too short' : null,
          ),
          FDSizedBox(height: 32),
          _sectionTitle('2. Binary Selection (Toggles)'),
          FDRow(
            children: [
              FDCheckbox(
                value: _checkboxVal,
                onChanged: (val) => setState(() => _checkboxVal = val),
              ),
              FDSizedBox(width: 8),
              FDText('I accept the Flart terms and conditions'),
            ],
          ),
          FDSizedBox(height: 16),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FDText('Enable Quantum Notifications'),
              FDSwitch(
                value: _switchVal,
                onChanged: (val) => setState(() => _switchVal = val),
              ),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('3. Multi-choice (Radio)'),
          FDColumn(
            children: [
              _buildRadioOption(1, 'Stable Build'),
              _buildRadioOption(2, 'Beta Stream'),
              _buildRadioOption(3, 'Nightly Canary'),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('4. Icon Buttons & Gestures'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FDIconButton(
                icon: FDIcon(icon: FDIcons.refresh, color: theme.primaryColor),
                onPressed: () => reRenderApp(),
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.delete, color: theme.errorColor),
                onPressed: () {
                  print('Deleted!');
                },
              ),
              FDIconButton(
                icon: FDIcon(icon: FDIcons.share, color: theme.successColor),
                onPressed: () {
                  print('Shared!');
                },
              ),
            ],
          ),
          FDSizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRadioOption(int value, String label) {
    return FDPadding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: FDGestureDetector(
        onTap: () => setState(() => _radioVal = value),
        child: FDRow(
          children: [
            FDRadio<int>(
              value: value,
              groupValue: _radioVal,
              onChanged: (val) => setState(() => _radioVal = val),
            ),
            FDSizedBox(width: 12),
            FDText(label),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return FDPadding(
      padding: EdgeInsets.only(bottom: 16),
      child: FDText(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
