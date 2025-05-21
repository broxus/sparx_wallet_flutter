import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class NotNullNotifier<T> extends ChangeNotifier implements ListenableState<T> {
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

  void accept(T newValue) {
    if (_disposed || _value == newValue) return;

    _value = newValue;
    notifyListeners();
  }
}
