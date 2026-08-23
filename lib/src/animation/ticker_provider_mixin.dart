import '../../flartdart.dart';
import '../foundation/ticker.dart';

/// A mixin that provides a single [Ticker].
/// This mixin only supports vending a single ticker. If you need multiple, 
/// you would use TickerProviderStateMixin.
mixin SingleTickerProviderStateMixin<T extends StatefulWidget> on State<T> implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(_ticker == null, 'SingleTickerProviderStateMixin only supports a single Ticker.');
    _ticker = Ticker(onTick);
    return _ticker!;
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}
