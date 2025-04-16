import 'dart:html';

typedef AnimationListener = void Function();
typedef AnimationCallback = void Function(double value);

class AnimationController {
  final Duration duration;
  final VoidCallback? onCompleted;
  final List<AnimationListener> _listeners = [];
  late num _startTime;
  bool _isAnimating = false;

  double _value = 0.0;
  double get value => _value;

  AnimationController({
    required this.duration,
    this.onCompleted,
  });

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void addListener(AnimationListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AnimationListener listener) {
    _listeners.remove(listener);
  }

  void _animate(num timestamp) {
    if (!_isAnimating) return;

    _startTime ??= timestamp;
    final progress = (timestamp - _startTime) / duration.inMilliseconds;
    _value = progress.clamp(0.0, 1.0);
    _notifyListeners();

    if (_value < 1.0) {
      window.requestAnimationFrame(_animate);
    } else {
      _value = 1.0;
      _notifyListeners();
      _isAnimating = false;
      onCompleted?.call();
    }
  }

  void forward() {
    _isAnimating = true;
    _startTime = 0;
    _value = 0.0;
    window.requestAnimationFrame(_animate);
  }

  void stop() {
    _isAnimating = false;
  }

  void reset() {
    _startTime = 0;
    _value = 0.0;
    _notifyListeners();
  }
}



//final controller = AnimationController(
//   duration: Duration(seconds: 1),
//   onUpdate: (value) {
//     print("Progress: $value");
//   },
//   onCompleted: () {
//     print("Animation done");
//   },
// );
//
// controller.forward();