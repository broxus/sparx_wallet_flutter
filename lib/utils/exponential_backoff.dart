import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart' show visibleForTesting;

/// A utility class for implementing exponential backoff retry logic with
/// configurable behavior
class ExponentialBackoff {
  /// Creates an ExponentialBackoff instance
  ///
  /// [initialDuration] - Duration to wait before the first retry
  /// [multiplier] - Factor by which the delay increases after each attempt
  /// [maxAttempts] - Maximum number of retry attempts before giving up
  /// [maxDelay] - Optional cap on how long a delay can grow
  /// (defaults to no limit)
  /// [jitter] - Random jitter factor between 0.0 and 1.0 to add to delays
  /// (helps prevent thundering herd)
  ExponentialBackoff({
    required this.initialDuration,
    required this.multiplier,
    required this.maxAttempts,
    this.maxDelay,
    this.jitter = 0.0,
    Random? random,
  })  : assert(
          multiplier >= 1.0,
          'Multiplier must be greater than or equal to 1.0',
        ),
        assert(maxAttempts > 0, 'Max attempts must be greater than 0'),
        assert(
          jitter >= 0.0 && jitter <= 1.0,
          'Jitter must be between 0.0 and 1.0',
        ),
        _random = random ?? (jitter > 0 ? Random() : null);

  final Duration initialDuration;
  final double multiplier;
  final int maxAttempts;
  final Duration? maxDelay;
  final double jitter;
  final Random? _random;

  @visibleForTesting
  Duration calculateNextDelay(Duration currentDelay) {
    var nextDelay = currentDelay * multiplier;

    if (maxDelay != null && nextDelay > maxDelay!) {
      nextDelay = maxDelay!;
    }

    if (jitter > 0 && _random != null) {
      final jitterMs =
          (nextDelay.inMilliseconds * jitter * _random.nextDouble()).toInt();
      nextDelay = Duration(milliseconds: nextDelay.inMilliseconds - jitterMs);
    }

    return nextDelay;
  }

  /// Executes the provided action with exponential backoff retry logic
  ///
  /// [action] - The function to execute with retry capabilities
  /// [onException] - Optional callback for handling exceptions with stacktraces
  /// [shouldRetry] - Optional predicate to determine if a specific exception
  /// should trigger retry
  /// Returns the result of [action] if successful
  /// Throws the last caught exception if all retry attempts fail
  Future<T> run<T>(
    FutureOr<T> Function() action, {
    void Function(Object exception, StackTrace stackTrace, int attempt)?
        onException,
    bool Function(Object exception, StackTrace stackTrace)? shouldRetry,
  }) async {
    var delay = initialDuration;
    Object? lastException;
    StackTrace? lastStackTrace;

    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await action();
      } catch (e, stackTrace) {
        lastException = e;
        lastStackTrace = stackTrace;

        onException?.call(e, stackTrace, attempt);

        if (shouldRetry != null && !shouldRetry(e, stackTrace)) {
          Error.throwWithStackTrace(e, stackTrace);
        }

        if (attempt == maxAttempts) {
          break;
        }

        await Future<void>.delayed(delay);

        delay = calculateNextDelay(delay);
      }
    }

    if (lastException != null && lastStackTrace != null) {
      Error.throwWithStackTrace(lastException, lastStackTrace);
    }

    throw Exception('Max attempts reached without successful completion');
  }
}
