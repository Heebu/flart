# Flart 🎨

**A high-performance, Flutter-inspired UI framework for pure Dart Web applications.**

[![pub package](https://img.shields.io/pub/v/flartdart.svg?color=blue)](https://pub.dev/packages/flartdart)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Platform: Web](https://img.shields.io/badge/platform-web-lightgrey.svg)]()

Build stunning, responsive, and interactive web applications using the familiar declarative syntax of Flutter—all in 100% pure Dart. Flart bridges the gap between the power of web technologies (HTML/CSS/JS) and the developer experience of Flutter.

---

## 🚀 Why Flart?

- **🎯 Flutter-Native Syntax**: If you know Flutter, you know Flart. Use `Row`, `Column`, `Container`, `Scaffold`, and `StatefulWidget` just like you do in Flutter.
- **🏗️ 100+ Pre-built Widgets**: From basic layout components to complex pickers, media players, and animated transitions.
- **🎨 Global Theming (v1.2)**: Instant Light/Dark mode switching using the `Theme` InheritedWidget. Define your brand once, apply it everywhere.
- **⚡ Virtualized Performance (v1.2)**: Handle lists with 10,000+ items at 60fps using `FDVirtualizedListView`.
- **⚙️ Zero External Dependencies**: A lightweight core built on top of standard web APIs.
- **🛠️ Integrated CLI**: Generate project templates instantly with the `flartdart` command.
- **⚡ Performance First**: Lightweight HTML/CSS rendering with optimized DOM updates.
- **📱 Responsive by Design**: Built-in `MediaQuery` and flexible layout widgets for seamless mobile & desktop support.
- **Interactive Widget Lab**: A comprehensive testing suite organized into 5 batches (Foundation, Lists & Nav, Interactive, Content, and Animations) for systematic widget verification and developer onboarding.
---

## 🛠️ CLI Tool

The fastest way to get started is by using the **Flartdart CLI**.

### Installation

```bash
dart pub global activate flartdart
```

### Usage

```bash
# Create a new project
flartdart create my_awesome_app

# Run your app
cd my_awesome_app
dart pub get
dart run build_runner serve
```

---

## 📦 Installation

Add `flartdart` to your `pubspec.yaml`:

```yaml
dependencies:
  flartdart: ^1.0.0
```

Then, fetch the dependencies:

```bash
dart pub get
```

---

## 🎬 Quick Start

### The Classic "Hello World"

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
      title: 'My First Flart App',
      home: FDScaffold(
        appBar: FDAppBar(
          title: FDText('Hello Flart!'),
          backgroundColor: FlartColors.blue,
        ),
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: AxisAlignment.center,
            children: [
              FDContainer(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: FlartColors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: '#00000033', blurRadius: 10)
                  ],
                ),
                child: FDText(
                  'Welcome to the future of Dart Web 🚀',
                  style: TextStyle(color: FlartColors.white, fontSize: 20),
                ),
              ),
              FDSizedBox(height: 24),
              FDElevatedButton(
                onPressed: () => print('Let\'s build something!'),
                child: FDText('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🧩 Comprehensive Widget Ecosystem

Flart is divided into logical categories to help you build everything from simple blogs to complex dashboards.

### 🏗️ Structure & Layout
*   `FDScaffold`, `FDAppBar`, `FDDrawer`, `FDBottomNavigationBar`
*   `FDContainer`, `FDCard`, `FDColumn`, `FDRow`, `FDStack`, `FDWrap`
*   `FDListView`, `FDGridView`, `FDSingleChildScrollView`

### ✍️ Text & Typography
*   `FDText`, `FDRichText`, `FDTextSpan`, `FDLinkText`, `FDSelectableText`

### 🖱️ Buttons & Interaction
*   `FDElevatedButton`, `FDTextButton`, `FDIconButton`, `FDGestureDetector`

### 📝 Forms & Inputs
*   `FDTextField`, `FDTextFormField`, `TextArea`, `FDCheckbox`, `FDSwitch`, `FDSlider`
*   `AutocompleteField`, `ColorPicker`, `FileUpload`

### 📅 Pickers
*   `FDDatePicker`, `FDTimePicker`, `FDDateRangePicker`, `FDMonthPicker`, `FDWeekPicker`, `DateTimePicker`

### 🎬 Animations & Effects
*   `AnimatedContainer`, `AnimatedOpacity`, `AnimatedScale`, `AnimatedRotation`, `FadeIn`
*   `AnimationController`, `Tween`, `Curves`

### 🎥 Media & Painting
*   `VideoPlayer`, `AudioPlayer`, `YouTubePlayer`, `MapEmbed`
*   `FDCustomPaint`, `FDSvgPicture`

---

## 🏗️ Architecture: The Bridge

Flart works by transpiling Dart widget structures into highly optimized HTML, CSS, and interactive JavaScript. 

1.  **Declaration**: You define your UI in Dart using a nested widget tree.
2.  **Rendering**: Each widget implements a `render()` method that returns a string of HTML/CSS.
3.  **Interactivity**: Event callbacks (like `onPressed`) are managed via a `CallbackManager` that bridges JavaScript events back into Dart logic.
4.  **State**: `StatefulWidget` provides a familiar lifecycle (`initState`, `setState`, `dispose`) for managing dynamic data.

---

## 📖 Resource Links

- 📚 **[Detailed Widget Guide](WIDGET_GUIDE.md)**: Exhaustive reference with code samples for every widget.
- 🤝 **[Contributing](CONTRIBUTING.md)**: Learn how to help us improve Flart.
- 🚀 **[Example Projects](example/)**: Real-world implementations and demos.
- 📄 **[Changelog](CHANGELOG.md)**: Stay updated with the latest releases.

---

## 🤝 Contributing

We love contributions! Whether it's fixing a bug, adding a new widget, or improving the documentation, your help is welcome. Please check out our [Contributing Guidelines](CONTRIBUTING.md).

---

## 📜 License

Flart is open-source software licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more information.

---

<p align="center">
  <b>Built with ❤️ for the Dart Community</b>
</p>
