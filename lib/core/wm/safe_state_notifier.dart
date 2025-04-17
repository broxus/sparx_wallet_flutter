import 'package:elementary_helper/elementary_helper.dart';

class SafeStateNotifier<T> extends StateNotifier<T> {
  SafeStateNotifier({super.initValue});

  bool _disposed = false;

  @override

  /// Accepts a new value and notifies listeners if not disposed.
  void accept(T? newValue) {
    if (_disposed) return;
    super.accept(newValue);
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
