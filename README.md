# Flart 🎨

**A comprehensive Flutter-inspired UI framework for Dart Web applications**

[![pub package](https://img.shields.io/pub/v/flart.svg)](https://pub.dev/packages/flart)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Build beautiful, responsive web applications using familiar Flutter-style widgets and APIs - all in pure Dart with zero dependencies.

---

## 🌟 Why Flart?

- **🎯 100+ Widgets** - Complete widget library for any web application
- **🎨 Flutter-Style API** - Familiar syntax for Flutter developers
- **🚀 Zero Dependencies** - Pure Dart, lightweight and fast
- **📱 Responsive** - Works on mobile and desktop
- **🎭 Rich Animations** - Smooth CSS-based animations
- **📝 Complete Forms** - Built-in validation and error handling
- **🎬 Media Support** - Video, audio, YouTube, maps
- **🎮 Gesture Detection** - 20+ touch and mouse events

---

## 📦 Installation

Add Flart to your `pubspec.yaml`:

```yaml
dependencies:
  flart: ^1.0.0
```

Then run:
```bash
dart pub get
```

---

## 🚀 Quick Start
 
 ### Hello World
 
 ```dart
 import 'package:flart/flartdart.dart';
 
 void main() {
   runApp(const MyApp());
 }
 
 class MyApp extends StatelessWidget {
   const MyApp();
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       home: Scaffold(
         appBar: AppBar(
           title: Text('Hello Flart!'),
           backgroundColor: FlartColors.blue,
         ),
         body: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'Welcome to Flart! 🎨',
                 style: TextStyle(
                   fontSize: 32,
                   fontWeight: FontWeight.bold,
                   color: FlartColors.blue,
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
     ).render(context);
   }
 }
 ```
 
 ---
 
 ## 📚 What's Included
 
 ### Widget Categories (100+)
 
 #### 🏗️ Structure (15)
 `Scaffold`, `AppBar`, `Container`, `Card`, `Drawer`, `BottomNavigationBar`, `FloatingActionButton`, `Dialog`, `Divider`, `VerticalDivider`, `SizedBox`, `Spacer`, `Expanded`, `Image`, `Icon`, `MaterialApp`, `PageNavigator`
 
 #### 📐 Layout (8)
 `Row`, `Column`, `Stack`, `Positioned`, `Center`, `Align`, `ListView`, `GridView`
 
 #### 📝 Input & Forms (15)
 `TextField`, `TextFormField`, `TextArea`, `Checkbox`, `Radio`, `Switch`, `Slider`, `DropdownButton`, `Form`, `FormField`, `AutocompleteField`, `ColorPicker`, `FileUpload`
 
 #### 🔘 Buttons (5)
 `Button`, `ElevatedButton`, `TextButton`, `IconButton`, `GestureDetector`
 
 #### 📄 Text (4)
 `Text`, `RichText`, `EditableText`, `LinkText`, `SelectableText`
 
 #### 📅 Pickers (9)
 `DatePicker`, `TimePicker`, `ImagePicker`, `DateRangePicker`, `MonthPicker`, `WeekPicker`, `DateTimePicker`, `RangePicker`
 
 #### 🎬 Animations (10)
 `AnimationController`, `AnimatedContainer`, `AnimatedOpacity`, `AnimatedScale`, `AnimatedRotation`, `AnimatedSlide`, `AnimatedPositioned`, `AnimatedSize`, `AnimatedCrossFade`, `FadeIn`
 
 #### 🎥 Media (5)
 `VideoPlayer`, `AudioPlayer`, `YouTubePlayer`, `IFrame`, `MapEmbed`
 
 #### 🎨 Display (7)
 `Chip`, `Badge`, `Tooltip`, `SnackBar`, `CircularProgressIndicator`, `LinearProgressIndicator`, `TabBar`, `TabBarView`
 
 #### 🖌️ Painting (2)
 `CustomPaint`, `SvgPicture`
 
 ---
 
 ## 💡 Feature Highlights
 
 ### Complete Form System
 
 ```dart
 Form(
child: Column(
     children: [
       TextFormField(
         label: 'Email',
         keyboardType: TextInputType.email,
         validator: (value) => 
           value?.contains('@') == true ? null : 'Invalid email',
         prefixIcon: Icon(icon: Icons.email),
       ),
       TextFormField(
         label: 'Password',
         obscureText: true,
         validator: (value) =>
           value != null && value.length >= 8 ? null : 'Too short',
       ),
       ElevatedButton(
         onPressed: () => submitForm(),
         child: Text('Submit'),
       ),
     ],
   ),
 )
 ```

### Rich Animations

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  width: isExpanded ? 200 : 100,
  height: isExpanded ? 200 : 100,
  decoration: BoxDecoration(
    color: isExpanded ? FlartColors.blue : FlartColors.red,
    borderRadius: BorderRadius.circular(isExpanded ? 20 : 10),
  ),
)
```

### Comprehensive Gesture Detection

```dart
GestureDetector(
  onTap: () => print('Tapped!'),
  onDoubleTap: () => print('Double tap!'),
  onLongPress: () => print('Long press!'),
  onSwipeLeft: () => navigateNext(),
  onSwipeRight: () => navigateBack(),
  onHover: () => showTooltip(),
  onPanUpdate: () => updatePosition(),
  child: MyWidget(),
)
```

### Media Integration

```dart
Column(
  children: [
    VideoPlayer(
      src: '/videos/demo.mp4',
      controls: true,
      poster: '/images/thumbnail.jpg',
    ),
    YouTubePlayer(
      videoId: 'dQw4w9WgXcQ',
      width: 560,
      height: 315,
    ),
    MapEmbed(
      location: 'New York, NY',
      zoom: 15,
    ),
  ],
)
```

### Advanced Pickers

```dart
Column(
  children: [
    DateRangePicker(
      label: 'Select Dates',
      onChanged: (range) => print('${range.start} to ${range.end}'),
    ),
    DateTimePicker(
      label: 'Appointment',
      onChanged: (dateTime) => scheduleAppointment(dateTime),
    ),
    RangePicker(
      label: 'Price Range',
      min: 0,
      max: 1000,
      onChanged: (range) => filterByPrice(range),
    ),
  ],
)
```

---

## 🎨 Styling System

Flart provides a comprehensive styling system similar to Flutter:

```dart
Container(
  width: 300,
  height: 200,
  decoration: BoxDecoration(
    color: FlartColor.hex('#007bff'),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: 'rgba(0,0,0,0.2)',
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    gradient: LinearGradient(
      colors: [FlartColors.red, FlartColors.green],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: Text('Styled Container'),
)
```

---

## 🎯 Use Cases

Perfect for building:
- ✅ **Admin Dashboards** - Rich data displays and forms
- ✅ **Landing Pages** - Beautiful, responsive layouts
- ✅ **Web Applications** - Full-featured SPAs
- ✅ **Interactive Forms** - Complex validation and input
- ✅ **Media Sites** - Video and audio integration
- ✅ **E-commerce** - Product catalogs and checkout

---

## 📖 Documentation

- **[Widget Guide](WIDGET_GUIDE.md)** - Complete reference for all widgets
- **[API Documentation](https://pub.dev/documentation/flart/latest/)** - Detailed API docs
- **[Examples](example/)** - Working code examples
- **[Changelog](CHANGELOG.md)** - Version history

---

## 🏗️ Architecture

Flart uses a simple, efficient architecture:

1. **Widgets** - Declarative UI components
2. **Render** - HTML generation
3. **Styles** - CSS-based styling
4. **Events** - JavaScript event handling

All widgets extend the base `Widget` class and implement a `render()` method that returns HTML.

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

---

## 📊 Package Stats

- **100+ Widgets** across 10 categories
- **Zero Dependencies** - Pure Dart implementation
- **9 Animation Widgets** - Smooth transitions
- **15 Input Widgets** - Complete form system
- **5 Media Widgets** - Rich media support
- **9 Picker Widgets** - Date, time, and more
- **20+ Gesture Events** - Comprehensive interaction

---

## 🔧 Development

### Setup

```bash
git clone https://github.com/Heebu/flart.git
cd flart
dart pub get
```

### Run Examples

```bash
cd example
dart run build_runner serve
```

### Run Tests

```bash
dart test
```

### Code Quality

```bash
dart analyze
dart format .
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

Inspired by Flutter's elegant widget system, Flart brings the power of declarative UI to Dart Web development.

---

## 🌐 Links

- **Package**: [pub.dev/packages/flart](https://pub.dev/packages/flart)
- **Repository**: [github.com/Heebu/flart](https://github.com/Heebu/flart)
- **Issues**: [github.com/Heebu/flart/issues](https://github.com/Heebu/flart/issues)
- **Documentation**: [pub.dev/documentation/flart](https://pub.dev/documentation/flart/latest/)

---

## ⭐ Show Your Support

If you find Flart useful, please consider:
- ⭐ Starring the repository
- 👍 Liking the package on pub.dev
- 🐛 Reporting issues
- 💡 Suggesting features
- 🤝 Contributing code

---

**Made with ❤️ for the Dart community**

*Flart - Flutter-style UI for Dart Web*
