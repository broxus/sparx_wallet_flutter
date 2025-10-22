import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:flutter/cupertino.dart';

/// Successor of ChangeNotifier and Listenable.
/// Analog of SafeStateNotifier, but accepting only non-null values.
///
/// Ensures that the value is not null.
/// There is no need to write additional null checks when working with value.
class NotNullNotifier<T> extends ChangeNotifier
    implements NotNullListenableState<T> {
  NotNullNotifier(T initValue) : _value = initValue;

  @override
  T get value => _value;

  T _value;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    listener.call();
  }

  void accept(T newValue, {bool isUnique = true}) {
    if (_disposed || isUnique && _value == newValue) return;

    _value = newValue;
    notifyListeners();
  }
}
