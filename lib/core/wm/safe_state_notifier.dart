import 'package:elementary_helper/elementary_helper.dart';

class SafeStateNotifier<T> extends StateNotifier<T> {
  SafeStateNotifier({super.initValue});

  bool _disposed = false;

  /// Accepts a new value and notifies listeners if not disposed.
  @override
  void accept(T? newValue) {
    if (_disposed) return;
    super.accept(newValue);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }
}
