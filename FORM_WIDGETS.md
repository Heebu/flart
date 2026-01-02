# Complete Form and Input Widgets

## Summary
Added comprehensive form and input widgets to Flart, including TextField, FormField, TextFormField, TextArea, AutocompleteField, ColorPicker, and FileUpload.

---

## Input Widgets

### 1. **TextField**
A fully-featured text input with validation, icons, and styling.

**Features:**
- Label and placeholder support
- Prefix and suffix icons
- Error and helper text
- Different input types (text, email, number, phone, url)
- Password obscuring
- Max length
- Enabled/disabled/readonly states
- Custom styling
- Focus states with animations

**Example:**
```dart
TextField(
  label: 'Email',
  placeholder: 'Enter your email',
  keyboardType: TextInputType.email,
  prefixIcon: Icon(icon: 'email'),
  errorText: 'Invalid email',
  helperText: 'We\'ll never share your email',
  onChanged: (value) => print(value),
  onSubmitted: (value) => submitForm(),
)
```

### 2. **TextFormField**
TextField with built-in validation support.

**Example:**
```dart
TextFormField(
  label: 'Password',
  obscureText: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  },
  onSaved: (value) => savePassword(value),
)
```

### 3. **TextArea**
Multi-line text input.

**Features:**
- Configurable rows
- Character counter
- Max length
- Resizable
- Error and helper text

**Example:**
```dart
TextArea(
  label: 'Description',
  placeholder: 'Enter description...',
  rows: 6,
  maxLength: 500,
  helperText: 'Describe your project',
  onChanged: (value) => print(value),
)
```

### 4. **AutocompleteField**
Input with autocomplete suggestions.

**Example:**
```dart
AutocompleteField(
  label: 'Country',
  placeholder: 'Type to search...',
  suggestions: ['USA', 'UK', 'Canada', 'Australia'],
  prefixIcon: Icon(icon: 'search'),
  onSelected: (value) => print('Selected: $value'),
)
```

### 5. **ColorPicker**
Native color picker input.

**Example:**
```dart
ColorPicker(
  label: 'Choose Color',
  initialColor: FlartColors.blue,
  onChanged: (color) => updateTheme(color),
)
```

### 6. **FileUpload**
File upload with custom button.

**Example:**
```dart
FileUpload(
  label: 'Upload Image',
  accept: 'image/*',
  multiple: false,
  buttonText: 'Choose Image',
  onChanged: (files) => uploadFiles(files),
)
```

---

## Form Widgets

### 1. **Form**
Container for form fields with validation.

**Example:**
```dart
Form(
  key: formKey,
  onChanged: () => print('Form changed'),
  child: Column(
    children: [
      TextFormField(
        label: 'Name',
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      ),
      TextFormField(
        label: 'Email',
        keyboardType: TextInputType.email,
        validator: (value) => validateEmail(value),
      ),
      ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Text('Submit'),
      ),
    ],
  ),
)
```

### 2. **FormField**
Generic form field wrapper with validation.

**Example:**
```dart
FormField<String>(
  initialValue: 'default',
  validator: (value) => value == null ? 'Required' : null,
  onSaved: (value) => saveData(value),
  builder: (state) {
    return Column(
      children: [
        CustomInput(
          value: state.value,
          onChanged: state.didChange,
        ),
        if (state.errorText != null)
          Text(state.errorText!, style: TextStyle(color: FlartColors.red)),
      ],
    );
  },
)
```

---

## Complete Form Example

```dart
class RegistrationForm extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Name field
          TextFormField(
            label: 'Full Name',
            placeholder: 'John Doe',
            prefixIcon: Icon(icon: 'person'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16),
          
          // Email field
          TextFormField(
            label: 'Email',
            placeholder: 'john@example.com',
            keyboardType: TextInputType.email,
            prefixIcon: Icon(icon: 'email'),
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Invalid email';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16),
          
          // Password field
          TextFormField(
            label: 'Password',
            obscureText: true,
            prefixIcon: Icon(icon: 'lock'),
            helperText: 'At least 8 characters',
            validator: (value) {
              if (value == null || value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16),
          
          // Bio textarea
          TextArea(
            label: 'Bio',
            placeholder: 'Tell us about yourself...',
            rows: 4,
            maxLength: 200,
          ),
          
          SizedBox(height: 16),
          
          // Country autocomplete
          AutocompleteField(
            label: 'Country',
            suggestions: ['USA', 'UK', 'Canada', 'Australia'],
            prefixIcon: Icon(icon: 'public'),
          ),
          
          SizedBox(height: 24),
          
          // Submit button
          ElevatedButton(
            onPressed: () => submitForm(),
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
```

---

## Validation Helpers

```dart
// Email validator
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

// Password validator
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain uppercase letter';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain a number';
  }
  return null;
}

// Phone validator
String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone is required';
  }
  final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Invalid phone format';
  }
  return null;
}
```

---

## Files Created

1. `lib/src/widgets/inputs/textfield.dart` - TextField widget
2. `lib/src/widgets/inputs/form_field.dart` - Form, FormField, TextFormField
3. `lib/src/widgets/inputs/advanced_inputs.dart` - TextArea, AutocompleteField, ColorPicker, FileUpload

---

## All Exported

All widgets are available via:
```dart
import 'package:flart/flart.dart';
```

Flart now has a complete form system ready for production use! 🎉
