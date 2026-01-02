# Picker Files - InputElement Fix

## Issue
The picker files (`date_picker.dart`, `time_picker.dart`, `image_picker.dart`) were getting errors on the line:
```dart
final input = document.getElementById(id) as InputElement?;
```

## Root Cause
The files were missing the `dart:html` import, which is required to access:
- `document` object
- `InputElement` class
- DOM manipulation methods

## Fixes Applied

### 1. date_picker.dart
**Added:**
```dart
import 'dart:html';
```

This allows the `attachHandler` method to properly access `InputElement` and `document`.

### 2. time_picker.dart
**Added:**
```dart
import 'dart:html';
```

This allows the `attachHandler` method to properly access `InputElement` and `document`.

### 3. image_picker.dart
**Changed:**
```dart
// Before
import 'dart:io';
typedef ImagePickCallback = void Function(List<File> files);

// After
import 'dart:html' as html;
typedef ImagePickCallback = void Function(List<html.File> files);
```

**Reason:** 
- `dart:io` is for server-side Dart and doesn't work in web browsers
- `dart:html` is the correct library for web applications
- Used `html.File` to distinguish from `dart:io`'s `File` class

## Result
✅ All picker files now properly import `dart:html`
✅ `InputElement` is now accessible
✅ `document.getElementById()` works correctly
✅ Web-compatible file handling in `image_picker.dart`

## Files Modified
1. `lib/src/widgets/pickers/date_picker.dart`
2. `lib/src/widgets/pickers/time_picker.dart`
3. `lib/src/widgets/pickers/image_picker.dart`
