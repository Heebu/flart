# New Widgets Added to Flart

## Summary
Added 8 new animated widgets and 15+ useful general-purpose widgets to make Flart more feature-complete and production-ready.

---

## Animated Widgets (8 new)

### 1. **AnimatedOpacity**
Smoothly transitions opacity of a widget.
```dart
AnimatedOpacity(
  opacity: 0.5,
  duration: Duration(milliseconds: 500),
  child: Text('Fading text'),
)
```

### 2. **AnimatedPositioned**
Animates position changes within a Stack.
```dart
AnimatedPositioned(
  left: 100,
  top: 50,
  duration: Duration(milliseconds: 300),
  child: Container(...),
)
```

### 3. **AnimatedRotation**
Rotates a widget smoothly.
```dart
AnimatedRotation(
  turns: 0.5, // 180 degrees
  duration: Duration(milliseconds: 500),
  child: Icon(icon: 'refresh'),
)
```

### 4. **AnimatedScale**
Scales a widget up or down.
```dart
AnimatedScale(
  scale: 1.5,
  duration: Duration(milliseconds: 300),
  child: Text('Scaled!'),
)
```

### 5. **AnimatedSlide**
Slides a widget using offset.
```dart
AnimatedSlide(
  offset: Offset(0.5, 0), // Slide 50% right
  duration: Duration(milliseconds: 400),
  child: Container(...),
)
```

### 6. **AnimatedSize**
Animates size changes automatically.
```dart
AnimatedSize(
  duration: Duration(milliseconds: 300),
  child: Container(...),
)
```

### 7. **AnimatedCrossFade**
Crossfades between two children.
```dart
AnimatedCrossFade(
  firstChild: Text('First'),
  secondChild: Text('Second'),
  showFirst: true,
  duration: Duration(milliseconds: 500),
)
```

### 8. **FadeIn**
Automatically fades in when rendered.
```dart
FadeIn(
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
  child: Text('I fade in!'),
)
```

---

## Structure Widgets (7 new)

### 1. **Card**
Material Design card with elevation.
```dart
Card(
  elevation: 2.0,
  padding: EdgeInsets.all(16),
  child: Text('Card content'),
)
```

### 2. **CircularProgressIndicator**
Spinning circular loader.
```dart
CircularProgressIndicator(
  size: 40,
  strokeWidth: 4,
  color: FlartColors.blue,
)
```

### 3. **LinearProgressIndicator**
Horizontal progress bar (determinate or indeterminate).
```dart
LinearProgressIndicator(
  value: 0.7, // 70% complete, or null for indeterminate
  height: 4,
)
```

### 4. **Chip**
Compact element with optional avatar and delete button.
```dart
Chip(
  label: Text('Flutter'),
  avatar: Icon(icon: 'code'),
  onDeleted: () => print('Deleted'),
)
```

### 5. **Badge**
Notification badge overlay.
```dart
Badge(
  label: '5',
  child: Icon(icon: 'notifications'),
)
```

### 6. **Tooltip**
Shows message on hover.
```dart
Tooltip(
  message: 'Click me!',
  child: IconButton(...),
)
```

### 7. **SnackBar**
Temporary bottom message.
```dart
SnackBar(
  content: Text('Action completed!'),
  duration: Duration(seconds: 3),
  action: TextButton(label: 'UNDO', onPressed: ...),
)
```

### 8. **TabBar & TabBarView**
Tabbed navigation.
```dart
TabBar(
  tabs: [Text('Tab 1'), Text('Tab 2')],
  currentIndex: 0,
  onTap: (index) => print(index),
)

TabBarView(
  currentIndex: 0,
  children: [Widget1(), Widget2()],
)
```

---

## Input Widgets (5 new)

### 1. **Checkbox**
Standard checkbox input.
```dart
Checkbox(
  value: true,
  onChanged: (value) => print(value),
)
```

### 2. **Radio**
Radio button for option selection.
```dart
Radio<String>(
  value: 'option1',
  groupValue: selectedValue,
  onChanged: (value) => setState(() => selectedValue = value),
)
```

### 3. **Switch**
Toggle switch.
```dart
Switch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)
```

### 4. **DropdownButton**
Dropdown/select menu.
```dart
DropdownButton<String>(
  value: selectedItem,
  items: [
    DropdownMenuItem(value: '1', child: Text('Option 1')),
    DropdownMenuItem(value: '2', child: Text('Option 2')),
  ],
  onChanged: (value) => print(value),
)
```

### 5. **Slider**
Range slider input.
```dart
Slider(
  value: 0.5,
  min: 0.0,
  max: 1.0,
  divisions: 10,
  onChanged: (value) => print(value),
)
```

---

## Enhancements

### EdgeInsets.symmetric
Added symmetric constructor for easier padding/margin:
```dart
EdgeInsets.symmetric(horizontal: 16, vertical: 8)
```

---

## Files Created

### Animated Widgets
- `lib/src/widgets/animated_widgets/animated_opacity.dart`
- `lib/src/widgets/animated_widgets/animated_positioned.dart`
- `lib/src/widgets/animated_widgets/animated_rotation.dart`
- `lib/src/widgets/animated_widgets/animated_scale.dart`
- `lib/src/widgets/animated_widgets/animated_slide.dart`
- `lib/src/widgets/animated_widgets/animated_size.dart`
- `lib/src/widgets/animated_widgets/animated_crossfade.dart`
- `lib/src/widgets/animated_widgets/fade_in.dart`

### Structure Widgets
- `lib/src/widgets/structure/card.dart`
- `lib/src/widgets/structure/progress_indicator.dart`
- `lib/src/widgets/structure/chip_badge.dart`
- `lib/src/widgets/structure/tooltip_snackbar.dart`
- `lib/src/widgets/structure/tabs.dart`

### Input Widgets
- `lib/src/widgets/inputs/form_inputs.dart`
- `lib/src/widgets/inputs/dropdown_slider.dart`

---

## All Exported in flart.dart

All new widgets are now available via:
```dart
import 'package:flart/flart.dart';
```

No need for individual imports - everything is accessible from the main package!
