import 'types.dart';

abstract class Listenable {
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
}

class ChangeNotifier implements Listenable {
  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void dispose() {
    _listeners.clear();
  }
}

class ValueNotifier<T> extends ChangeNotifier {
  T _value;
  ValueNotifier(this._value);

  T get value => _value;
  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }
}
