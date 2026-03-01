# FlartDart 🚀

**A Comprehensive, Developer-First Flutter-Inspired Framework for Dart Web Applications.**

FlartDart brings the power, reactivity, and declarative UI of Flutter to the web using pure Dart. No external dependencies, no complex transpilation—just clean, performant, and beautiful web apps.

---

## 🌟 Key Features (v1.3.0)

*   **100+ Core Widgets**: Everything from `FDContainer` and `FDColumn` to `FDSliverAppBar` and `FDDataTable`.
*   **Reactive State Management**: Implementation of `ChangeNotifier`, `FDProvider`, and a **Stacked-style** `FDViewModelBuilder`.
*   **Native-feel Animations**: High-level `FDAnimate` helper, `Hero` transitions (foundation), and built-in transitions for all interactive widgets.
*   **Modern Routing**: Sophisticated `PageNavigator` with **Path Parameters** (e.g., `/user/:id`) and history management.
*   **Forms & Validation**: Integrated `FDForm` and `FDTextFormField` with easy validation logic and `GlobalKey` control.
*   **Premium UI Components**: `FDSkeleton` shimmer loaders, `FDSliverAppBar` with scroll effects, and `FDSnackBar`.
*   **Flutter-Style Canvas**: A high-level `Canvas` and `Paint` API for custom 2D drawing.

---

## 🚀 Getting Started

### 1. Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  flartdart: ^1.3.0
```

### 2. A Simple Reactive App

```dart
import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flart App',
      home: const HomePage(),
    );
  }
}
```

---

## 🏛️ Modern Architecture

### Stacked-style ViewModels
Tired of complex state registration? Use `FDViewModelBuilder` for zero-config reactive logic:

```dart
class CounterViewModel extends ViewModel {
  int count = 0;
  void increment() {
    count++;
    notifyListeners();
  }
}

// In your View
FDViewModelBuilder<CounterViewModel>(
  viewModelBuilder: () => CounterViewModel(),
  builder: (context, model, child) => FDText('Count: ${model.count}'),
)
```

---

## 🛣️ Advanced Routing

Flart supports path parameters out of the box:

```dart
// Registering routes
PageNavigator.routes = {
  '/': (params) => const HomePage(),
  '/details/:id': (params) => DetailPage(id: params['id']!),
};

// Navigating
PageNavigator.pushNamed('/details/42');
```

---

## 🎨 Premium UI & Animations

### 🎬 Entrance Animations
Bring your UI to life with a single wrapper:

```dart
FDAnimate(
  fadeIn: true,
  slideY: 20,
  duration: Duration(milliseconds: 600),
  child: MyCard(),
)
```

### 🧱 Shimmer Loaders
Perfect for modern data-fetching UX:

```dart
isLoading 
  ? FDSkeleton(height: 100, borderRadius: BorderRadius.circular(8)) 
  : RealContent()
```

### 🖌️ Custom Painting
Use the high-level `Canvas` API:

```dart
class MyPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(100, 100, 50, Paint()..color = FlartColors.blue);
  }
}
```

---

## 🏗️ Building for Production

Flart is designed to be lightweight. To bundle your app:

1.  **Compile to Javascript**:
    ```bash
    dart compile js -O2 web/main.dart -o build/main.js
    ```
2.  **Optimize**: Use the `-O2` or `-O4` flags for tree-shaking and minification.

---

## 📄 License & Contribution
Flart is Open Source. We love contributors! Check our [GitHub Issues](https://github.com/Heebu/flart/issues) to see what we're working on.

Created with ❤️ by the **Heebu Team**.
