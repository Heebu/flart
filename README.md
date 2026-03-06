# FlartDart 🚀

**A Comprehensive, Developer-First Flutter-Inspired Framework for Dart Web Applications.**

FlartDart brings the power, reactivity, and declarative UI of Flutter to the web using pure Dart. No external dependencies, no complex transpilation—just clean, performant, and beautiful web apps.

---

## 🌟 Key Features (v1.4.0)

*   **Integrated CLI**: A powerful `flartdart` tool for project creation, serving, and building.
*   **Responsive Power**: Built-in `ScreenUtil` and numeric extensions (`.w`, `.h`, `.sp`) for perfect UI across devices.
*   **100+ Core Widgets**: Everything from `FDContainer` and `FDColumn` to `FDSliverAppBar` and `FDDataTable`.
*   **Reactive State Management**: Implementation of `ChangeNotifier`, `FDProvider`, and a **Stacked-style** `FDViewModelBuilder`.
*   **Native-feel Animations**: High-level `FDAnimate` helper, `Hero` transitions (foundation), and built-in transitions for all interactive widgets.
*   **Modern Routing**: Sophisticated `PageNavigator` with **Path Parameters** (e.g., `/user/:id`) and history management.
*   **Forms & Validation**: Integrated `FDForm` and `FDTextFormField` with easy validation logic and `GlobalKey` control.

---

## 🛠️ Flartdart CLI

The framework comes with a dedicated CLI to manage your projects.

### 1. Installation
Activate the tool globally from the package source:
```bash
dart pub global activate --source path .
```

### 2. Available Commands
| Command | Description |
| :--- | :--- |
| `flartdart create <name>` | Create a new project with responsive boilerplate |
| `flartdart run` | Start a dev server with Hot Reload (on port 8080) |
| `flartdart run -r` | Run in optimized Release/Production mode |
| `flartdart build -r` | Build the project for deployment (output in `web/build/`) |
| `flartdart clean` | Clear build artifacts and logs |
| `flartdart doctor` | Verify your environment setup |

---

## 📱 Responsive Design (ScreenUtil)

Flart treats responsiveness as a first-class citizen. Using the `1440x900` desktop design standard by default, you can scale any number.

### 1. Initialize
```dart
void main() {
  ScreenUtil.init(); // Defaults to 1440x900
  runApp(const MyApp());
}
```

### 2. Use Responsive Units
```dart
FDContainer(
  width: 300.w,  // Scaled width
  height: 200.h, // Scaled height
  padding: EdgeInsets.all(20.w),
  child: FDText(
    'Responsive Title',
    style: TextStyle(fontSize: 24.sp), // Scaled font
  ),
)
```

| Extension | Unit | Description |
| :--- | :--- | :--- |
| `.w` | Width | Scales based on screen width |
| `.h` | Height | Scales based on screen height |
| `.sp` | Font Size | Scales based on width (recommended for text) |
| `.sw` / `.sh` | Screen % | Percentage of screen 0.0 - 100.0 |

---

## 🚀 Getting Started

### 1. Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  flartdart: ^1.4.0
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

## 📡 Async Flow & Builders

Flart brings Flutter's signature async patterns to Dart web. Use `StreamBuilder` for real-time data flows and `FutureBuilder` for one-time fetches.

### 📡 StreamBuilder
Listen to any stream (like WebSockets) and rebuild automatically:

```dart
FDStreamBuilder<int>(
  stream: myTimerStream(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const FDText('Connecting...');
    }
    return FDText('Current Value: ${snapshot.data}');
  },
)
```

---

## 🛠️ Building for Production

To build your application for production:

```bash
flartdart build --release
```

Optimization and tree-shaking are handled automatically by the CLI.

---

## 💳 Support the Project

If you love Flartdart and find it useful, consider supporting our development! Your contributions help us maintain the framework and build new features.

[!["Support via PayPal"](https://img.shields.io/badge/Donate-PayPal-blue.svg?style=for-the-badge&logo=paypal)](https://www.paypal.com/donate/?hosted_button_id=QAK2GKLN4QDVW)

You can also use the CLI at any time to get the support link:
```bash
flartdart donate
```

---

## 📄 License & Contribution
Flart is Open Source. We love contributors! Check our [GitHub Issues](https://github.com/Heebu/flart/issues) to see what we're working on.

Created with ❤️ by the **Heebu Team**.
