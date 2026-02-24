import 'dart:html';

class Input {
  static final Set<String> _keysDown = {};
  static Point _mousePosition = const Point(0, 0);
  static bool _isInitialized = false;

  static void init() {
    if (_isInitialized) return;
    _isInitialized = true;

    window.onKeyDown.listen((e) => _keysDown.add(e.key ?? ''));
    window.onKeyUp.listen((e) => _keysDown.remove(e.key ?? ''));
    window.onMouseMove.listen((e) => _mousePosition = e.client);
  }

  static bool isKeyDown(String key) => _keysDown.contains(key);

  static Point get mousePosition => _mousePosition;

  /// Common keys for games
  static const String keyW = 'w';
  static const String keyA = 'a';
  static const String keyS = 's';
  static const String keyD = 'd';
  static const String keySpace = ' ';
  static const String keyArrowUp = 'ArrowUp';
  static const String keyArrowDown = 'ArrowDown';
  static const String keyArrowLeft = 'ArrowLeft';
  static const String keyArrowRight = 'ArrowRight';
}
