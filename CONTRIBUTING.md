# Contributing to Flart

Thank you for your interest in contributing to Flart! 🎉

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/Heebu/flart/issues)
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Code samples if applicable
   - Dart/Browser version

### Suggesting Features

1. Check existing [Issues](https://github.com/Heebu/flart/issues) for similar suggestions
2. Create a new issue with:
   - Clear use case
   - Proposed API (if applicable)
   - Examples of how it would be used

### Pull Requests

1. **Fork** the repository
2. **Create a branch** for your feature/fix
3. **Make your changes**
4. **Test your changes** thoroughly
5. **Update documentation** if needed
6. **Submit a pull request**

#### PR Guidelines

- Follow existing code style
- Add tests for new features
- Update CHANGELOG.md
- Keep commits focused and atomic
- Write clear commit messages

## Development Setup

```bash
# Clone the repository
git clone https://github.com/Heebu/flart.git
cd flart

# Get dependencies
dart pub get

# Run tests
dart test

# Run example
cd example
dart run build_runner serve
```

## Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

## Widget Development

When creating new widgets:

1. Extend `StatelessWidget` (implement `build`), `StatefulWidget` (implement `createState`), or `Widget` (implement `render` for low-level control)
3. Use semantic HTML
4. Add proper accessibility attributes
5. Include documentation comments
6. Add examples in documentation

Example:

```dart
/// A custom widget that displays a greeting.
/// 
/// Example:
/// ```dart
/// GreetingWidget(
///   name: 'World',
///   style: TextStyle(fontSize: 24),
/// )
/// ```
class GreetingWidget extends Widget {
  final String name;
  final TextStyle? style;

  GreetingWidget({required this.name, this.style});

  @override
  String render(BuildContext context) {
    // Implementation
  }
}
```

## Testing

- Write unit tests for new features
- Ensure all tests pass before submitting PR
- Aim for high code coverage

## Documentation

- Update README.md for new features
- Add examples for new widgets
- Update CHANGELOG.md
- Add inline documentation

## Questions?

Feel free to ask questions in:
- [GitHub Discussions](https://github.com/Heebu/flart/discussions)
- [Issues](https://github.com/Heebu/flart/issues)

## Code of Conduct

Be respectful, inclusive, and constructive. We're all here to make Flart better!

---

Thank you for contributing to Flart! 🙏
