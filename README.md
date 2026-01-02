# Flart 🎨

A comprehensive **Flutter-inspired UI framework** for **Dart Web** applications. Build beautiful, responsive web apps using familiar Flutter-style widgets and APIs.

[![pub package](https://img.shields.io/pub/v/flart.svg)](https://pub.dev/packages/flart)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 🎯 **100+ Widgets** - Comprehensive widget library
- 🎨 **Flutter-Style API** - Familiar syntax for Flutter developers
- 🚀 **Zero Dependencies** - Pure Dart web framework
- 📱 **Responsive** - Mobile and desktop ready
- 🎭 **Animations** - Rich animation support
- 📝 **Forms** - Complete form system with validation
- 🎬 **Media** - Video, audio, YouTube, maps
- 🎨 **Theming** - Customizable styles and colors

## 🚀 Quick Start

### Installation

Add Flart to your `pubspec.yaml`:

```yaml
dependencies:
  flart: ^1.0.0
```

### Basic Example

```dart
import 'package:flart/flart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flart!'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: AxisAlignment.center,
            children: [
              Text(
                'Welcome to Flart',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: 'bold',
                  color: '#007bff',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => print('Button clicked!'),
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 📚 Widget Categories

### Structure Widgets
- `Scaffold`, `AppBar`, `Container`, `Card`
- `Drawer`, `BottomNavigationBar`, `FloatingActionButton`
- `Dialog`, `Divider`, `SizedBox`, `Spacer`, `Expanded`

### Layout Widgets
- `Row`, `Column`, `Stack`, `Positioned`
- `Center`, `Align`, `ListView`, `GridView`

### Input & Forms
- `TextField`, `TextFormField`, `TextArea`
- `Checkbox`, `Radio`, `Switch`
- `Slider`, `DropdownButton`
- `Form`, `FormField` with validation

### Buttons
- `Button`, `ElevatedButton`, `TextButton`, `IconButton`
- `GestureDetector` with 20+ gesture events

### Text Widgets
- `Text`, `RichText`, `EditableText`, `LinkText`

### Pickers
- `DatePicker`, `TimePicker`, `ImagePicker`
- `DateRangePicker`, `MonthPicker`, `WeekPicker`
- `DateTimePicker`, `ColorPicker`, `RangePicker`

### Animated Widgets
- `AnimatedContainer`, `AnimatedOpacity`, `AnimatedScale`
- `AnimatedRotation`, `AnimatedSlide`, `AnimatedPositioned`
- `AnimatedCrossFade`, `FadeIn`

### Media Widgets
- `VideoPlayer`, `AudioPlayer`, `YouTubePlayer`
- `IFrame`, `MapEmbed`, `Image`

### Display Widgets
- `Chip`, `Badge`, `Tooltip`, `SnackBar`
- `CircularProgressIndicator`, `LinearProgressIndicator`
- `TabBar`, `TabBarView`

### Painting
- `CustomPaint`, `SvgPicture`

## 🎨 Styling

Flart uses a familiar styling system:

```dart
Container(
  decoration: BoxDecoration(
    color: FlartColor.hex('#007bff'),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: 'rgba(0,0,0,0.1)',
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  padding: EdgeInsets.all(16),
  child: Text('Styled Container'),
)
```

## 🎭 Animations

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  width: isExpanded ? 200 : 100,
  height: isExpanded ? 200 : 100,
  color: isExpanded ? FlartColors.blue : FlartColors.red,
  child: Center(child: Text('Animated!')),
)
```

## 📝 Forms with Validation

```dart
Form(
  child: Column(
    children: [
      TextFormField(
        label: 'Email',
        keyboardType: TextInputType.email,
        validator: (value) {
          if (value == null || !value.contains('@')) {
            return 'Invalid email';
          }
          return null;
        },
      ),
      TextFormField(
        label: 'Password',
        obscureText: true,
        validator: (value) {
          if (value == null || value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () => submitForm(),
        child: Text('Submit'),
      ),
    ],
  ),
)
```

## 🎮 Gesture Detection

```dart
GestureDetector(
  onTap: () => print('Tapped!'),
  onDoubleTap: () => print('Double tapped!'),
  onLongPress: () => print('Long pressed!'),
  onSwipeLeft: () => print('Swiped left!'),
  onHover: () => print('Hovering...'),
  onPanUpdate: () => print('Panning...'),
  child: Container(
    width: 200,
    height: 200,
    color: FlartColors.blue,
  ),
)
```

## 🎬 Media Support

```dart
// Video
VideoPlayer(
  src: '/videos/demo.mp4',
  controls: true,
  autoplay: false,
)

// YouTube
YouTubePlayer(
  videoId: 'dQw4w9WgXcQ',
  width: 560,
  height: 315,
)

// Maps
MapEmbed(
  location: 'New York, NY',
  zoom: 15,
)
```

## 📖 Documentation

For detailed documentation and examples, visit:
- [API Documentation](https://pub.dev/documentation/flart/latest/)
- [GitHub Repository](https://github.com/yourusername/flart)
- [Examples](https://github.com/yourusername/flart/tree/main/example)

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Inspired by Flutter's elegant widget system, adapted for Dart Web.

## 📊 Package Stats

- **100+ Widgets**
- **8 Animation Widgets**
- **15+ Input Widgets**
- **5 Media Widgets**
- **9 Picker Widgets**
- **Zero Dependencies**

---

Made with ❤️ for the Dart community
