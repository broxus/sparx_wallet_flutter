import 'package:app/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EpochSecondsConverter', () {
    test('fromJson returns null for null input', () {
      // Arrange
      const converter = EpochSecondsConverter();

      // Act
      final result = converter.fromJson(null);

      // Assert
      expect(result, isNull);
    });

    test('fromJson returns seconds for int below threshold', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final input = DateTime.now().secondsSinceEpoch;

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(input));
    });

    test('fromJson converts milliseconds to seconds for int at threshold', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final input = DateTime.now().millisecondsSinceEpoch;

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(input ~/ 1000));
    });

    test('fromJson converts milliseconds to seconds for numeric input', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final num input = DateTime.now().millisecondsSinceEpoch.toDouble();

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(input.toInt() ~/ 1000));
    });

    test('fromJson floors numeric input before conversion', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final baseSeconds = DateTime.now().secondsSinceEpoch;
      final num input = baseSeconds + 0.9;

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(baseSeconds));
    });

    test('fromJson parses numeric string input', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final input = DateTime.now().secondsSinceEpoch.toString();

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(int.parse(input)));
    });

    test('fromJson converts milliseconds to seconds for string input', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final input = DateTime.now().millisecondsSinceEpoch.toString();

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, equals(int.parse(input) ~/ 1000));
    });

    test('fromJson returns null for non-numeric string', () {
      // Arrange
      const converter = EpochSecondsConverter();
      const input = 'not-a-number';

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, isNull);
    });

    test('fromJson returns null for unsupported type', () {
      // Arrange
      const converter = EpochSecondsConverter();
      const input = {'value': 1};

      // Act
      final result = converter.fromJson(input);

      // Assert
      expect(result, isNull);
    });

    test('toJson returns the same value', () {
      // Arrange
      const converter = EpochSecondsConverter();
      final input = DateTime.now().secondsSinceEpoch;

      // Act
      final result = converter.toJson(input);

      // Assert
      expect(result, equals(input));
    });
  });
}
