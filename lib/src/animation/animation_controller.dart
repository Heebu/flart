import '../../flartdart.dart';

typedef AnimationListener = void Function();
typedef AnimationStatusListener = void Function(AnimationStatus status);

enum AnimationStatus {
  dismissed,
  forward,
  reverse,
  completed,
}

class AnimationController {
  final Duration duration;
  final Duration? reverseDuration;
  final double lowerBound;
  final double upperBound;
  final AnimationBehavior animationBehavior;

  final List<AnimationListener> _listeners = [];
  final List<AnimationStatusListener> _statusListeners = [];

  AnimationStatus _status = AnimationStatus.dismissed;
  AnimationStatus get status => _status;

  double _value;
  double get value => _value;
  set value(double newValue) {
    final clamped = newValue.clamp(lowerBound, upperBound);
    if (_value != clamped) {
      _value = clamped;
      _notifyListeners();
    }
  }

  late final Ticker _ticker;
  double _startValue = 0.0;
  double _targetValue = 1.0;
  Duration _currentDuration = Duration.zero;
  Curve _currentCurve = Curves.linear;

  AnimationController({
    required this.duration,
    required TickerProvider vsync,
    this.reverseDuration,
    this.lowerBound = 0.0,
    this.upperBound = 1.0,
    this.animationBehavior = AnimationBehavior.normal,
    double value = 0.0,
  }) : _value = value.clamp(lowerBound, upperBound) {
    _ticker = vsync.createTicker(_tick);
  }

  void addListener(AnimationListener listener) {
    _listeners.add(listener);
  }

  void removeListener(AnimationListener listener) {
    _listeners.remove(listener);
  }

  void addStatusListener(AnimationStatusListener listener) {
    _statusListeners.add(listener);
  }

  void removeStatusListener(AnimationStatusListener listener) {
    _statusListeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in List.of(_listeners)) {
      listener();
    }
  }

  void _notifyStatusListeners(AnimationStatus status) {
    _status = status;
    for (final listener in List.of(_statusListeners)) {
      listener(status);
    }
  }

  void forward({double? from}) {
    if (from != null) value = from;
    _animateTo(upperBound, duration);
  }

  void reverse({double? from}) {
    if (from != null) value = from;
    _animateTo(lowerBound, reverseDuration ?? duration);
  }

  void animateTo(double target,
      {Duration? duration, Curve curve = Curves.linear}) {
    _animateTo(target, duration ?? this.duration, curve: curve);
  }

  void _animateTo(double target, Duration duration,
      {Curve curve = Curves.linear}) {
    _ticker.stop();
    _startValue = value;
    _targetValue = target;
    _currentDuration = duration;
    _currentCurve = curve;

    if (_startValue == _targetValue) {
      _notifyStatusListeners(_targetValue == upperBound
          ? AnimationStatus.completed
          : AnimationStatus.dismissed);
      return;
    }

    _notifyStatusListeners(_targetValue > _startValue
        ? AnimationStatus.forward
        : AnimationStatus.reverse);

    _ticker.start();
  }

  void _tick(Duration elapsed) {
    final durationMs = _currentDuration.inMilliseconds;
    
    // Protect against zero duration
    if (durationMs == 0) {
      value = _targetValue;
      _ticker.stop();
      _notifyStatusListeners(value == upperBound
          ? AnimationStatus.completed
          : AnimationStatus.dismissed);
      return;
    }

    final t = (elapsed.inMilliseconds / durationMs).clamp(0.0, 1.0);
    final transformedT = _currentCurve.transform(t);

    value = _startValue + (_targetValue - _startValue) * transformedT;

    if (t >= 1.0) {
      _ticker.stop();
      value = _targetValue;
      _notifyStatusListeners(value == upperBound
          ? AnimationStatus.completed
          : AnimationStatus.dismissed);
    }
  }

  void stop({bool canceled = true}) {
    _ticker.stop();
  }

  void reset() {
    stop();
    value = lowerBound;
    _notifyStatusListeners(AnimationStatus.dismissed);
  }

  void dispose() {
    _ticker.dispose();
    _listeners.clear();
    _statusListeners.clear();
  }
}

enum AnimationBehavior {
  normal,
  preserve,
}
