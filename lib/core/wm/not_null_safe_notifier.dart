import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:flutter/cupertino.dart';

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

  void accept(
    T newValue, {
    bool isUnique = true,
  }) {
    if (_disposed || isUnique && _value == newValue) return;

    _value = newValue;
    notifyListeners();
  }
}
