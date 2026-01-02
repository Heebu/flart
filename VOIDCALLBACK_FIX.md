# VoidCallback Fix

## Issue
Button files were showing the error:
```
Undefined class 'VoidCallback'.
Try changing the name to the name of an existing class, or creating a class with the name 'VoidCallback'.
```

## Root Cause
`VoidCallback` is a common typedef used throughout Flutter and Flart for callbacks that take no arguments and return no data. It was not defined anywhere in the Flart project.

## Solution

### 1. Created Foundation Types File
Created `lib/src/foundation/types.dart` with common typedefs:

```dart
/// A callback that takes no arguments and returns no data.
typedef VoidCallback = void Function();

/// A callback that takes a value and returns no data.
typedef ValueChanged<T> = void Function(T value);

/// A callback that takes a value and returns a boolean.
typedef ValueGetter<T> = T Function();
```

### 2. Added to Main Export
Updated `lib/flart.dart` to export the foundation types:

```dart
// Foundation
export 'src/foundation/types.dart';
```

### 3. Cleaned Up Unused Imports
Removed unused `dart:html` imports from files that were only using it for the typedef (which is now available through flart.dart):

- ✅ `lib/src/widgets/buttons/gesture_detector.dart`
- ✅ `lib/src/widgets/texts/link_text.dart`
- ✅ `lib/src/widgets/texts/text_button.dart`

## Result
✅ `VoidCallback` is now available throughout the project via `package:flart/flart.dart`
✅ All button widgets can use `VoidCallback` without errors
✅ Additional useful typedefs (`ValueChanged`, `ValueGetter`) are also available
✅ Cleaned up unnecessary imports

## Files Affected
- **Created**: `lib/src/foundation/types.dart`
- **Modified**: `lib/flart.dart`
- **Cleaned**: `gesture_detector.dart`, `link_text.dart`, `text_button.dart`

## Usage
Now all widgets can use these typedefs:

```dart
import 'package:flart/flart.dart';

class MyButton extends Widget {
  final VoidCallback? onPressed;
  final ValueChanged<String>? onTextChanged;
  
  MyButton({this.onPressed, this.onTextChanged});
  
  // ...
}
```
