import 'dart:math';
import 'package:web/web.dart';
import 'dart:js_interop';

class Input {
  static final Set<String> _keysDown = {};
  static Point _mousePosition = const Point(0, 0);
  static bool _isInitialized = false;

  static void init() {
    if (_isInitialized) return;
    _isInitialized = true;

    window.addEventListener(
        'keydown',
        ((Event e) {
          _keysDown.add((e as KeyboardEvent).key);
        }).toJS);
    window.addEventListener(
        'keyup',
        ((Event e) {
          _keysDown.remove((e as KeyboardEvent).key);
        }).toJS);
    window.addEventListener(
        'mousemove',
        ((Event e) {
          final me = e as MouseEvent;
          _mousePosition = Point(me.clientX, me.clientY);
        }).toJS);
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
