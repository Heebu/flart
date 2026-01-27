# Flart Widget Guide 📚

This guide provides a comprehensive reference for the 100+ widgets available in Flart. Each section includes descriptions, key properties, and practical code examples.

---

## Table of Contents

1.  [Core Components](#1-core-components)
2.  [Structural Widgets](#2-structural-widgets)
3.  [Layout & Arrangement](#3-layout--arrangement)
4.  [Styling & Decoration](#4-styling--decoration)
5.  [Input & Form Widgets](#5-input--form-widgets)
6.  [Button & Interaction Widgets](#6-button--interaction-widgets)
7.  [Text Widgets](#7-text-widgets)
8.  [Animation Widgets](#8-animation-widgets)
9.  [Media & Web Widgets](#9-media--web-widgets)
10. [Picker Widgets](#10-picker-widgets)
11. [Painting & Drawing](#11-painting--drawing)

---

## 1. Core Components

The building blocks of any Flart application.

### StatelessWidget
A widget that does not require mutable state.
```dart
class MyHeader extends StatelessWidget {
  final String title;
  const MyHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return FDText(title, style: TextStyle(fontSize: 24));
  }
}
```

### StatefulWidget
A widget that has mutable state.
```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return FDElevatedButton(
      onPressed: () => setState(() => count++),
      child: FDText('Count: $count'),
    );
  }
}
```

---

## 2. Structural Widgets

Widgets that define the skeleton of your application.

### FDScaffold
Implements the basic Material Design visual layout structure.
*   **Properties**: `appBar`, `body`, `drawer`, `floatingActionButton`, `bottomNavigationBar`.
```dart
FDScaffold(
  appBar: FDAppBar(title: FDText('Home')),
  body: FDCenter(child: FDText('Content')),
  floatingActionButton: FDFloatingActionButton(
    onPressed: () {},
    child: FDIcon(icon: FDIcons.add),
  ),
)
```

### FDAppBar
A Material Design app bar.
```dart
FDAppBar(
  title: FDText('Dashboard'),
  backgroundColor: FlartColors.blue,
  elevation: 4.0,
  actions: [
    FDIconButton(icon: FDIcons.search, onPressed: () {}),
  ],
)
```

### FDContainer
A convenience widget that combines common painting, positioning, and sizing widgets.
```dart
FDContainer(
  width: 100,
  height: 100,
  decoration: BoxDecoration(color: FlartColors.red),
  child: FDText('Box'),
)
```

---

## 3. Layout & Arrangement

Control how widgets are positioned relative to each other.

### FDRow & FDColumn
Layout children in a horizontal or vertical array.
```dart
FDColumn(
  mainAxisAlignment: AxisAlignment.center,
  crossAxisAlignment: AxisAlignment.start,
  children: [
    FDText('Item 1'),
    FDText('Item 2'),
  ],
)
```

### FDStack & FDPositioned
Layers children on top of each other.
```dart
FDStack(
  children: [
    FDContainer(width: 200, height: 200, color: FlartColors.grey),
    FDPositioned(
      top: 10,
      right: 10,
      child: FDIcon(icon: FDIcons.star),
    ),
  ],
)
```

### FDListView
A scrollable list of widgets.
```dart
FDListView(
  children: [
    FDListTile(title: FDText('List Item 1')),
    FDListTile(title: FDText('List Item 2')),
  ],
)

// Or use the builder for efficiency
FDListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) => FDText('Index: $index'),
)
```

---

## 4. Styling & Decoration

### BoxDecoration
Defines how to paint a box.
```dart
BoxDecoration(
  color: FlartColors.blue,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: FlartColors.black, width: 2),
  boxShadow: [
    BoxShadow(color: '#00000033', blurRadius: 10, offsetY: 5)
  ],
)
```

### TextStyle
Styling for text.
```dart
TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: FlartColors.indigo,
  fontFamily: 'Roboto',
)
```

---

## 5. Input & Form Widgets

### FDTextField
A basic text input field.
```dart
FDTextField(
  label: 'Username',
  placeholder: 'Enter your name',
  onChanged: (value) => print(value),
)
```

### FDCheckbox, FDSwitch, FDRadio
Boolean and selection inputs.
```dart
FDCheckbox(
  value: true,
  onChanged: (val) => setState(() => isChecked = val),
)

FDSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
)
```

### TextArea
A multi-line text input.
```dart
TextArea(
  label: 'Description',
  rows: 5,
  onChanged: (v) => print(v),
)
```

---

## 6. Button & Interaction Widgets

### FDElevatedButton, FDTextButton, FDIconButton
Various button styles.
```dart
FDElevatedButton(
  onPressed: () {},
  child: FDText('Submit'),
)

FDIconButton(
  icon: FDIcons.delete,
  onPressed: () {},
)
```

### FDGestureDetector
Detects various user interactions (tap, swipe, hover).
```dart
FDGestureDetector(
  onTap: () => print('Tapped!'),
  onHover: () => print('Hovering!'),
  child: FDContainer(width: 50, height: 50, color: FlartColors.amber),
)
```

---

## 7. Text Widgets

### FDText
The standard text widget.
```dart
FDText('Hello Flart', style: TextStyle(fontSize: 16))
```

### FDRichText
Displays text that uses multiple different styles.
```dart
FDRichText(
  text: FDTextSpan(
    children: [
      FDTextSpan(text: 'Bold ', style: TextStyle(fontWeight: FontWeight.bold)),
      FDTextSpan(text: 'Italic', style: TextStyle(fontStyle: 'italic')),
    ],
  ),
)
```

---

## 8. Animation Widgets

### AnimatedContainer
Automatically animates between two states.
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  width: isExpanded ? 200 : 100,
  color: isExpanded ? FlartColors.blue : FlartColors.red,
  child: FDText('Animate Me'),
)
```

### FadeIn
Simple entry animation.
```dart
FadeIn(
  duration: Duration(seconds: 1),
  child: FDText('I appeared slowly'),
)
```

---

## 9. Media & Web Widgets

### VideoPlayer & AudioPlayer
Native HTML5 media players.
```dart
VideoPlayer(
  src: 'assets/video.mp4',
  autoplay: false,
  controls: true,
)
```

### YouTubePlayer
Easily embed YouTube videos.
```dart
YouTubePlayer(videoId: 'dQw4w9WgXcQ')
```

### FDIframe
Embed external web content.
```dart
FDIframe(src: 'https://dart.dev')
```

---

## 10. Picker Widgets

### FDDatePicker & FDTimePicker
Input helpers for dates and times.
```dart
FDDatePicker(
  label: 'Select Date',
  onChanged: (date) => print(date),
)
```

### FDDateRangePicker
Select a start and end date.
```dart
FDDateRangePicker(
  label: 'Stay Duration',
  onChanged: (range) => print('${range.start} to ${range.end}'),
)
```

---

## 11. Painting & Drawing

### FDSvgPicture
Render SVG images directly.
```dart
FDSvgPicture.network('https://example.com/logo.svg')
```

### FDCustomPaint
Create low-level custom graphics.
```dart
FDCustomPaint(
  painter: MyPainter(),
  size: Size(200, 200),
)
```

---

## Need More Help?
Check the [GitHub Repository](https://github.com/Heebu/flart) for full source code and advanced examples.
