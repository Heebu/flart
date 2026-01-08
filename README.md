# Flart ðŸŽ¨

**A comprehensive Flutter-inspired UI framework for Dart Web applications**

[![pub package](https://img.shields.io/pub/v/flart.svg)](https://pub.dev/packages/flart)
[![License: MIT](https://img.shields.io/FDBadge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Build beautiful, responsive web applications using familiar Flutter-style widgets and APIs - all in pure Dart with zero dependencies.

---

## ðŸŒŸ Why Flart?

- **ðŸŽ¯ 100+ Widgets** - Complete widget library for any web application
- **ðŸŽ¨ Flutter-Style API** - Familiar syntax for Flutter developers
- **ðŸš€ Zero Dependencies** - Pure Dart, lightweight and fast
- **ðŸ“± Responsive** - Works on mobile and desktop
- **ðŸŽ­ Rich Animations** - Smooth CSS-based animations
- **ðŸ“ Complete Forms** - Built-in validation and error handling
- **ðŸŽ¬ Media Support** - Video, audio, YouTube, maps
- **ðŸŽ® Gesture Detection** - 20+ touch and mouse events
- **🎨 Custom Styling** - `rawCss` support for direct style injection

---

## ðŸ“¦ Installation

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

## ðŸš€ Quick Start
 
 ### Hello World
 
 ```dart
 import 'package:flartdart/flartdart.dart';
 
 void main() {
   runApp(const MyApp());
 }
 
 class MyApp extends StatelessWidget {
   const MyApp();
 
   @override
   Widget build(BuildContext context) {
     return FDMaterialApp(
       home: FDScaffold(
         FDAppBar: FDAppBar(
           title: FDText('Hello Flart!'),
           backgroundColor: FlartColors.blue,
         ),
         body: FDCenter(
           child: FDColumn(
             mainAxisAlignment: MainAxisAlignment.FDCenter,
             children: [
               FDText(
                 'Welcome to Flart! ðŸŽ¨',
                 style: TextStyle(
                   fontSize: 32,
                   fontWeight: FontWeight.bold,
                   color: FlartColors.blue,
                 ),
               ),
               FDSizedBox(height: 20),
               FDElevatedButton(
                 onPressed: () => print('FDButton clicked!'),
                 child: FDText('Click Me'),
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
 
 ## ðŸ“š What's Included
 
 ### Widget Categories (100+)
 
 #### ðŸ—ï¸ Structure (15)
 `FDScaffold`, `FDAppBar`, `FDContainer`, `FDCard`, `FDDrawer`, `FDBottomNavigationBar`, `FDFloatingActionButton`, `FDDialog`, `FDDivider`, `FDVerticalDivider`, `FDSizedBox`, `FDSpacer`, `FDExpanded`, `FDImage`, `FDIcon`, `FDMaterialApp`, `PageNavigator`
 
 #### ðŸ“ Layout (8)
 `FDRow`, `FDColumn`, `FDStack`, `FDPositioned`, `FDCenter`, `FDAlign`, `FDListView`, `FDGridView`
 
 #### ðŸ“ Input & Forms (15)
 `FDTextField`, `FDTextFormField`, `TextArea`, `FDCheckbox`, `FDRadio`, `FDSwitch`, `FDSlider`, `DropdownButton`, `Form`, `FormField`, `AutocompleteField`, `ColorPicker`, `FileUpload`
 
 #### ðŸ”˜ Buttons (5)
 `FDButton`, `FDElevatedButton`, `FDTextButton`, `FDIconButton`, `FDGestureDetector`
 
 #### ðŸ“„ FDText (4)
 `FDText`, `FDRichText`, `FDEditableText`, `FDLinkText`, `FDSelectableText`
 
 #### ðŸ“… Pickers (9)
 `FDDatePicker`, `FDTimePicker`, `FDImagePicker`, `FDDateRangePicker`, `FDMonthPicker`, `FDWeekPicker`, `DateTimePicker`, `RangePicker`
 
 #### ðŸŽ¬ Animations (10)
 `AnimationController`, `AnimatedContainer`, `AnimatedOpacity`, `AnimatedScale`, `AnimatedRotation`, `AnimatedSlide`, `AnimatedPositioned`, `AnimatedSize`, `AnimatedCrossFade`, `FadeIn`
 
 #### ðŸŽ¥ Media (5)
 `VideoPlayer`, `AudioPlayer`, `YouTubePlayer`, `FDIframe`, `MapEmbed`
 
 #### ðŸŽ¨ Display (7)
 `FDChip`, `FDBadge`, `FDTooltip`, `FDSnackBar`, `FDCircularProgressIndicator`, `FDLinearProgressIndicator`, `FDTabBar`, `FDTabBarView`
 
 #### ðŸ–Œï¸ Painting (2)
 `FDCustomPaint`, `FDSvgPicture`
 
 ---
 
 ## ðŸ’¡ Feature Highlights
 
 ### Complete Form System
 
 ```dart
 Form(
child: FDColumn(
     children: [
       FDTextFormField(
         label: 'Email',
         keyboardType: TextInputType.email,
         validator: (value) => 
           value?.contains('@') == true ? null : 'Invalid email',
         prefixIcon: FDIcon(FDIcon: FDIcons.email),
       ),
       FDTextFormField(
         label: 'Password',
         obscureText: true,
         validator: (value) =>
           value != null && value.length >= 8 ? null : 'Too short',
       ),
       FDElevatedButton(
         onPressed: () => submitForm(),
         child: FDText('Submit'),
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
FDGestureDetector(
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
FDColumn(
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
FDColumn(
  children: [
    FDDateRangePicker(
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

## ðŸŽ¨ Styling System

Flart provides a comprehensive styling system similar to Flutter:

```dart
FDContainer(
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
  child: FDText('Styled FDContainer'),
)
```

---

## ðŸŽ¯ Use Cases

Perfect for building:
- âœ… **Admin Dashboards** - Rich data displays and forms
- âœ… **Landing Pages** - Beautiful, responsive layouts
- âœ… **Web Applications** - Full-featured SPAs
- âœ… **Interactive Forms** - Complex validation and input
- âœ… **Media Sites** - Video and audio integration
- âœ… **E-commerce** - Product catalogs and checkout

---

## ðŸ“– Documentation

- **[Widget Guide](WIDGET_GUIDE.md)** - Complete reference for all widgets
- **[API Documentation](https://pub.dev/documentation/flart/latest/)** - Detailed API docs
- **[Examples](example/)** - Working code examples
- **[Changelog](CHANGELOG.md)** - Version history

---

## ðŸ—ï¸ Architecture

Flart uses a simple, efficient architecture:

1. **Widgets** - Declarative UI components
2. **Render** - HTML generation
3. **Styles** - CSS-based styling
4. **Events** - JavaScript event handling

All widgets extend the base `Widget` class and implement a `render()` method that returns HTML.

---

## ðŸ¤ Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

---

## ðŸ“Š Package Stats

- **100+ Widgets** across 10 categories
- **Zero Dependencies** - Pure Dart implementation
- **9 Animation Widgets** - Smooth transitions
- **15 Input Widgets** - Complete form system
- **5 Media Widgets** - Rich media support
- **9 Picker Widgets** - Date, time, and more
- **20+ Gesture Events** - Comprehensive interaction

---

## ðŸ”§ Development

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

## ðŸ“„ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ðŸ™ Acknowledgments

Inspired by Flutter's elegant widget system, Flart brings the power of declarative UI to Dart Web development.

---

## ðŸŒ Links

- **Package**: [pub.dev/packages/flart](https://pub.dev/packages/flart)
- **Repository**: [github.com/Heebu/flart](https://github.com/Heebu/flart)
- **Issues**: [github.com/Heebu/flart/issues](https://github.com/Heebu/flart/issues)
- **Documentation**: [pub.dev/documentation/flart](https://pub.dev/documentation/flart/latest/)

---

## â­ Show Your Support

If you find Flart useful, please consider:
- â­ Starring the repository
- ðŸ‘ Liking the package on pub.dev
- ðŸ› Reporting issues
- ðŸ’¡ Suggesting features
- ðŸ¤ Contributing code

---

**Made with â¤ï¸ for the Dart community**

*Flart - Flutter-style UI for Dart Web*



