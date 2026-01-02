# Flart 🚀
**A Flutter-inspired UI framework for the Web — built entirely with Dart**

Flart is a modern UI framework that enables developers to build **powerful, highly-customizable web applications using Dart**, while retaining the **developer experience, structure, and productivity of Flutter** — without sacrificing **direct control over HTML, CSS, and browser behavior**.

---

## 🌍 Why Flart Exists

The web is powerful — but fragmented.

Developers are often forced to choose between:
- Raw HTML/CSS/JS (maximum control, poor developer experience)
- JavaScript frameworks (React, Vue, etc.)
- Flutter Web (great DX, limited web-native control)

**Flart bridges this gap.**

It gives you:
- Flutter-like widget composition
- Dart-only development
- Direct access to HTML, CSS, DOM, and browser APIs
- Fine-grained control over layout, styling, SEO, and performance

Flart is **not Flutter Web**.  
Flart is **Dart for the Web, done right**.

---

## 🎯 Vision & Goals

> **Full control of the web using Dart — without losing productivity**

Flart aims to:
- Make Dart a first-class language for web UI development
- Combine Flutter’s declarative UI model with web-native power
- Eliminate abstraction lock-in
- Empower developers with choice and flexibility

---

## 🧠 Design Philosophy

### 1. Flutter-Inspired, Web-Native
Flart mirrors Flutter’s architecture:
- Widget-based composition
- Declarative UI
- Predictable rendering

But unlike Flutter Web, Flart:
- Renders real DOM elements
- Uses native CSS for layout
- Exposes browser APIs directly

---

### 2. Everything Is a Widget

```dart
Scaffold(
  appBar: AppBar(title: Text("Flart")),
  body: Center(
    child: Text("Hello Web"),
  ),
);
```

Widgets map directly to:
- HTML elements
- CSS layouts
- Browser events

No canvas rendering. No black boxes.

---

### 3. Dual Styling System (Flutter + CSS)

#### Flutter-Style API
```dart
Container(
  padding: EdgeInsets.all(16),
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
);
```

#### CSS-Style API
```dart
Container(
  cssStyle: {
    "background": "linear-gradient(...)",
    "box-shadow": "0 10px 40px rgba(0,0,0,.2)",
  },
);
```

Developers can mix both seamlessly.

---

## 🧱 Widget System Scope

### Layout
- Row, Column
- Stack, Positioned
- Expanded, Spacer, SizedBox
- ListView, GridView

### Input & Interaction
- GestureDetector
- TextField
- Button, IconButton
- Keyboard and pointer events

### Structure
- Scaffold
- AppBar
- Drawer
- BottomNavigationBar
- Dialogs & Modals

### Media & Graphics
- Image (lazy loading supported)
- Icons & SVGs
- CustomPaint (HTML Canvas)

---

## 🎞 Animation System

Flart provides a web-optimized animation engine:
- requestAnimationFrame-based
- CSS & JS hybrid animations
- Custom AnimationController
- Tweens, curves, sequences

Animations are explicit, predictable, and inspectable.

---

## 🧭 Navigation & Routing

- Declarative routing
- Browser history support
- Deep linking
- SEO-friendly URLs

Routing behaves like the web expects.

---

## 📐 Layout Engine

Flart relies on **native browser layout**:
- Flexbox
- Grid
- Absolute positioning

Benefits:
- Responsive layouts
- DevTools compatibility
- Predictable rendering
- High performance

---

## 🔍 SEO & Accessibility

SEO is a first-class citizen:
- Real HTML tags (h1–h6, p, span)
- Screen reader support
- Search engine indexing
- Meta tag control

---

## 🔌 JavaScript & Browser Interop

Flart allows:
- Direct JavaScript calls
- DOM access when needed
- Browser API usage (Storage, Media, Sensors)

All without abandoning Dart.

---

## 🧩 State Management

Flart is unopinionated:
- Local widget state
- Context-based state
- Controller-driven patterns
- External reactive solutions

You choose the pattern.

---

## 🛠 Developer Experience (DX)

Flart focuses on:
- Simple, readable APIs
- Minimal boilerplate
- Easy debugging
- Inspectable DOM output

Developers should always know **what their code produces**.

---

## 📦 Package Goals

- Modular architecture
- Lightweight runtime
- Tree-shakable builds
- Easy integration with existing web projects

---

## 🧪 Testing & Stability

Planned support:
- Widget testing
- DOM snapshot testing
- Performance benchmarking
- Regression safety

---

## 🚀 What Flart Is NOT

- ❌ Not a Flutter Web replacement
- ❌ Not a JavaScript framework wrapper
- ❌ Not canvas-based rendering
- ❌ Not restrictive or opinionated

Flart is **a Dart-first web framework with real web power**.

---

## 🛣 Roadmap (High Level)

1. Core widget & rendering system
2. Layout & styling engine
3. Navigation & MediaQuery
4. Animation framework
5. SEO & accessibility layer
6. Performance optimizations
7. Documentation & examples
8. Community & ecosystem growth

---

## 🤝 Contribution Philosophy

Flart is:
- Understandable
- Hackable
- Open for experimentation
- Built for long-term growth

---

## ❤️ Final Note

Flart exists for developers who love:
- Dart
- Flutter’s architecture
- The raw power of the web

And want **all three — without compromise**.

---

**Flart**  
> _Full control of the web. Powered by Dart._
