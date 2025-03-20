import 'dart:async';

class ExponentialBackoff {
  ExponentialBackoff({
    required this.initialDuration,
    required this.multiplier,
    required this.maxAttempts,
  });

  final Duration initialDuration;
  final double multiplier;
  final int maxAttempts;

  Future<T> run<T>(FutureOr<T> Function() action) async {
    var delay = initialDuration;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await action();
      } catch (_) {
        if (attempt == maxAttempts) rethrow;

        await Future<void>.delayed(delay);
        delay = delay * multiplier;
      }
    }

    throw Exception('Max attempts reached');
  }
}
