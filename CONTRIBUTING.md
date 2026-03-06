# Contributing to Flart 🤝

First off, thank you for considering contributing to Flart! It's people like you that make Flart such a great tool.

## 🌈 How Can I Contribute?

### Reporting Bugs 🐛
- Document the steps to reproduce the bug.
- Include information about your environment (Dart version, Browser, OS).
- Provide a minimal code sample that reproduces the issue.

### Suggesting Features 💡
- Explain why this feature would be useful.
- Provide examples of the proposed API.
- Check if it aligns with the "Flutter-like" philosophy of the project.

### Improving Documentation 📖
- Fix typos or update outdated information.
- Add better examples to `WIDGET_GUIDE.md`.
- Improve inline documentation comments (JSDoc-style for Dart).

---

## 💻 Local Development Setup

To set up your development environment:

1.  **Fork and Clone**:
    ```bash
    git clone https://github.com/Heebu/flart.git
    cd flart
    ```

2.  **Install Dependencies**:
    ```bash
    dart pub get
    ```

3.  **Test the CLI (Development Mode)**:
    You can test the CLI tool directly from the source:
    ```bash
    dart run bin/flartdart.dart doctor
    dart run bin/flartdart.dart create test_app --local-path .
    ```

4.  **Run the Example App**:
    ```bash
    cd example
    flartdart run
    ```

---

## 🎨 Widget Development Guidelines

When adding a new widget, please follow these conventions:

- **Naming**: Use the `FD` prefix for consistency (e.g., `FDMyNewWidget`).
- **Styles**: Always include a `style` or `decoration` property where applicable.
- **Raw CSS**: Include a `rawCss` property to allow users to override styles if needed.
- **Semantics**: Use semantic HTML tags (e.g., `<nav>`, `<aside>`, `<main>`) within the `render()` method.
- **Accessibility**: Add appropriate ARIA labels and roles.

### Example Widget Structure:
```dart
class FDNewWidget extends StatelessWidget {
  final Widget child;
  final String? rawCss;

  const FDNewWidget({required this.child, this.rawCss});

  @override
  Widget build(BuildContext context) {
    return FDContainer(
      rawCss: 'border: 1px solid blue; $rawCss',
      child: child,
    );
  }
}
```

---

## ✅ Pull Request Process

1.  Create a feature branch (`git checkout -b feature/amazing-feature`).
2.  Commit your changes (`git commit -m 'Add some amazing feature'`).
3.  Ensure all tests pass (`dart test`).
4.  Push to your fork (`git push origin feature/amazing-feature`).
5.  Open a Pull Request with a clear description of the changes.

---

## 📜 Code of Conduct
We are committed to providing a friendly, safe, and welcoming environment for all. Please be respectful and constructive in your communications.

Happy Coding! 🚀
