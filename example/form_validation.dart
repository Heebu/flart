import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const FormDemo());
}

class FormDemo extends StatelessWidget {
  const FormDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Form Validation Demo',
      home: FDScaffold(
        appBar: FDAppBar(title: FDText('Validated Registration 📝')),
        body: FDCenter(
          child: FDSingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FDFormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Show success
      reRenderApp(); // Mock snackbar would be better but let's re-render
      print('Form is valid! Saving data...');
    } else {
      print('Form has errors.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FDForm(
      key: _formKey,
      child: FDColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FDText('Create an Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          FDSizedBox(height: 32),
          FDTextFormField(
            label: 'Full Name',
            placeholder: 'John Doe',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) => print('Saving Name: $value'),
          ),
          FDSizedBox(height: 20),
          FDTextFormField(
            label: 'Email Address',
            placeholder: 'john@example.com',
            keyboardType: TextInputType.email,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          FDSizedBox(height: 20),
          FDTextFormField(
            label: 'Password',
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          FDSizedBox(height: 32),
          FDContainer(
            width: double.infinity,
            child: FDElevatedButton(
              onPressed: _submit,
              child: FDText('Register Account'),
            ),
          ),
          FDSizedBox(height: 16),
          FDTextButton(
            onPressed: () => _formKey.currentState?.reset(),
            label: 'Reset Form',
          ),
        ],
      ),
    );
  }
}
