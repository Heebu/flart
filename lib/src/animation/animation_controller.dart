import 'dart:html';
import 'package:flart/src/animation/curves.dart';

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
    _value = newValue.clamp(lowerBound, upperBound);
    _notifyListeners();
  }

  AnimationController({
    required this.duration,
    this.reverseDuration,
    this.lowerBound = 0.0,
    this.upperBound = 1.0,
    this.animationBehavior = AnimationBehavior.normal,
    double value = 0.0,
  }) : _value = value.clamp(lowerBound, upperBound);

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

  int? _animationFrameId;
  num? _startTime;
  double _startValue = 0.0;
  double _targetValue = 1.0;

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
    if (_animationFrameId != null) {
      window.cancelAnimationFrame(_animationFrameId!);
      _animationFrameId = null;
    }

    _startValue = value;
    _targetValue = target;
    _startTime = null;

    if (_startValue == _targetValue) {
      _notifyStatusListeners(_targetValue == upperBound
          ? AnimationStatus.completed
          : AnimationStatus.dismissed);
      return;
    }

    _notifyStatusListeners(_targetValue > _startValue
        ? AnimationStatus.forward
        : AnimationStatus.reverse);

    void tick(num timestamp) {
      if (_startTime == null) {
        _startTime = timestamp;
        _animationFrameId = window.requestAnimationFrame(tick);
        return;
      }

      final elapsed = (timestamp - _startTime!).toInt();
      final durationMs = duration.inMilliseconds;
      final t = (elapsed / durationMs).clamp(0.0, 1.0);

      final transformedT = curve.transform(t);

      value = _startValue + (_targetValue - _startValue) * transformedT;

      if (elapsed < durationMs) {
        _animationFrameId = window.requestAnimationFrame(tick);
      } else {
        value = _targetValue;
        _notifyStatusListeners(value == upperBound
            ? AnimationStatus.completed
            : AnimationStatus.dismissed);
        _animationFrameId = null;
      }
    }

    _animationFrameId = window.requestAnimationFrame(tick);
  }

  void stop() {
    if (_animationFrameId != null) {
      window.cancelAnimationFrame(_animationFrameId!);
      _animationFrameId = null;
    }
  }

  void reset() {
    stop();
    value = lowerBound;
    _notifyStatusListeners(AnimationStatus.dismissed);
  }

  void dispose() {
    stop();
    _listeners.clear();
    _statusListeners.clear();
  }
}

enum AnimationBehavior {
  normal,
  preserve,
}
