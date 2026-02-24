import 'dart:html';

typedef TickerCallback = void Function(Duration elapsed);

class Ticker {
  final TickerCallback _onTick;
  int? _animationFrameId;
  Duration _startTime = Duration.zero;
  bool _isActive = false;

  Ticker(this._onTick);

  bool get isActive => _isActive;

  void start() {
    if (_isActive) return;
    _isActive = true;
    _startTime = Duration.zero;
    _scheduleTick();
  }

  void stop() {
    _isActive = false;
    if (_animationFrameId != null) {
      window.cancelAnimationFrame(_animationFrameId!);
      _animationFrameId = null;
    }
  }

  void _scheduleTick() {
    _animationFrameId = window.requestAnimationFrame(_tick);
  }

  void _tick(num highResTime) {
    if (!_isActive) return;

    final timestamp = Duration(microseconds: (highResTime * 1000).toInt());
    if (_startTime == Duration.zero) {
      _startTime = timestamp;
    }

    final elapsed = timestamp - _startTime;
    _onTick(elapsed);

    if (_isActive) {
      _scheduleTick();
    }
  }

  void dispose() {
    stop();
  }
}
