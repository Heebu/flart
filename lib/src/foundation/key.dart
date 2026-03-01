abstract class Key {
  const factory Key(String value) = ValueKey;
  const Key._();
}

class ValueKey<T> extends Key {
  final T value;
  const ValueKey(this.value) : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ValueKey<T> && other.value == value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueKey($value)';
}

class UniqueKey extends Key {
  UniqueKey() : super._();
  @override
  String toString() => 'UniqueKey#$hashCode';
}

class GlobalKey<T> extends Key {
  final String _id;
  GlobalKey()
      : _id = 'globalkey_${DateTime.now().microsecondsSinceEpoch}',
        super._();

  T? _currentState;
  T? get currentState => _currentState;

  // Internal usage by framework
  void setInternalState(dynamic state) {
    if (state is T) {
      _currentState = state;
    }
  }

  @override
  String toString() => _id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is GlobalKey<T> && other._id == _id);

  @override
  int get hashCode => _id.hashCode;
}
