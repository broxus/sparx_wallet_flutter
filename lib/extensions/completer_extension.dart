import 'dart:async';

extension CompleterExtension<T> on Completer<T> {
  void completeSafe([FutureOr<T>? value]) {
    try {
      if (isCompleted) {
        return;
      }
      complete(value);
    } catch (_) {}
  }
}
