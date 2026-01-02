// Common type definitions used throughout Flart

/// A callback that takes no arguments and returns no data.
typedef VoidCallback = void Function();

/// A callback that takes a value and returns no data.
typedef ValueChanged<T> = void Function(T value);

/// A callback that takes a value and returns a boolean.
typedef ValueGetter<T> = T Function();
