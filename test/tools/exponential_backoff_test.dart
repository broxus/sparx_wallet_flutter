import 'dart:async';
import 'dart:math' as math;

import 'package:app/utils/exponential_backoff.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockRandom extends Mock implements math.Random {}

void main() {
  group('ExponentialBackoff', () {
    test('successfully returns value on first attempt', () async {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 10),
        multiplier: 2,
        maxAttempts: 3,
      );

      final result = await backoff.run(() => 'success');

      expect(result, equals('success'));
    });

    test('retries until success', () async {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 10),
        multiplier: 2,
        maxAttempts: 3,
      );

      var attempts = 0;

      final result = await backoff.run(() {
        attempts++;
        if (attempts < 2) {
          throw Exception('Simulated failure');
        }
        return 'success after retry';
      });

      expect(attempts, equals(2));
      expect(result, equals('success after retry'));
    });

    test('calls onException callback for each failed attempt', () async {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 10),
        multiplier: 2,
        maxAttempts: 3,
      );

      var callbackCalls = 0;
      final attemptNumbers = <int>[];

      var attempts = 0;

      final result = await backoff.run(
        () {
          attempts++;
          if (attempts < 3) {
            throw Exception('Simulated failure');
          }
          return 'success after retries';
        },
        onException: (e, stackTrace, attempt) {
          callbackCalls++;
          attemptNumbers.add(attempt);
        },
      );

      expect(callbackCalls, equals(2));
      expect(attemptNumbers, equals([1, 2]));
      expect(result, equals('success after retries'));
    });

    test(
      'respects shouldRetry predicate',
      () async {
        final backoff = ExponentialBackoff(
          initialDuration: const Duration(milliseconds: 10),
          multiplier: 2,
          maxAttempts: 3,
        );

        // We'll create two different exception types
        final retriableException = TimeoutException('Timeout');
        final nonRetriableException = ArgumentError('Invalid argument');

        var attempts = 0;

        // This should succeed because the first exception is retriable
        await expectLater(
          backoff.run(
            () {
              attempts++;
              if (attempts == 1) {
                throw retriableException;
              } else if (attempts == 2) {
                // This won't be retried and will be rethrown
                throw nonRetriableException;
              }
              return 'success';
            },
            shouldRetry: (e, _) => e is TimeoutException,
          ),
          throwsA(isA<ArgumentError>()),
        );
      },
    );

    test('throws the last exception after max attempts', () async {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 10),
        multiplier: 2,
        maxAttempts: 3,
      );

      // This special exception helps us verify that the exact same
      // exception object is being rethrown
      final specificException = StateError('Specific error');

      try {
        await backoff.run(() {
          throw specificException;
        });
      } catch (e) {
        // Verify it's the exact same exception object
        expect(identical(e, specificException), isTrue);
      }
    });

    test('applies maximum delay cap', () async {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 100),
        multiplier: 10, // This would grow very quickly without a cap
        maxAttempts: 3,
        maxDelay: const Duration(milliseconds: 500), // Cap at 500ms
      );

      var attempts = 0;
      final stopwatch = Stopwatch()..start();

      try {
        await backoff.run(() {
          attempts++;
          throw Exception('Always fail');
        });
      } catch (e) {
        // We expect it to fail after maxAttempts
      }

      stopwatch.stop();

      // The delays should be:
      // 1st attempt: no delay
      // After 1st failure: 100ms delay
      // After 2nd failure: 500ms delay (capped from 1000ms)
      // Total expected delay: ~600ms (plus a small amount for code execution)
      // We'll assert it's less than 800ms to allow for execution time
      // and greater than 550ms to ensure the cap is being applied
      expect(stopwatch.elapsedMilliseconds, lessThan(800));
      expect(stopwatch.elapsedMilliseconds, greaterThan(550));
      expect(attempts, equals(3));
    });

    test('withJitter factory creates valid instance', () {
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 100),
        multiplier: 2,
        maxAttempts: 5,
        maxDelay: const Duration(seconds: 30),
        jitter: 0.2,
      );

      // Check default values
      expect(
        backoff.initialDuration,
        equals(const Duration(milliseconds: 100)),
      );
      expect(backoff.multiplier, equals(2.0));
      expect(backoff.maxAttempts, equals(5));
      expect(
        backoff.maxDelay,
        equals(const Duration(seconds: 30)),
      );
      expect(backoff.jitter, equals(0.2));
    });

    test('jitter modifies the delay', () {
      // Create a mock Random to control the jitter
      final mockRandom = MockRandom();

      // Configure the mock to always return 0.5
      when(mockRandom.nextDouble).thenReturn(0.5);

      // Create a test subclass that uses our mock
      final backoff = ExponentialBackoff(
        initialDuration: const Duration(milliseconds: 100),
        multiplier: 2,
        maxAttempts: 3,
        jitter: 0.4, // 40% jitter
        random: mockRandom,
      );

      // Calculate next delay from initial - with 40% jitter
      // and mock returning 0.5,
      // we expect 20% reduction (0.4 * 0.5 = 0.2)
      final nextDelay = backoff.calculateNextDelay(backoff.initialDuration);

      // Expected: 100ms * 2 (multiplier) * (1 - 0.4*0.5) = 200ms * 0.8 = 160ms
      expect(nextDelay, equals(const Duration(milliseconds: 160)));
    });
  });
}
