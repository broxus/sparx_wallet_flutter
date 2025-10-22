import 'dart:typed_data';

import 'package:app/feature/ledger/domain/ledger_app/ledger_data_reader.dart';
import 'package:test/test.dart';

void main() {
  group('LedgerDataReader', () {
    group('fromBytes', () {
      test('creates reader from valid bytes', () {
        // Arrange: Create valid APDU response
        // Format: [header..., data_length, actual_data, sw1, sw2]
        // data_length (3) includes: 1 data byte + 2 SW bytes
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x03, 0xAA, 0x90, 0x00];

        // Act
        final reader = LedgerDataReader.fromBytes(bytes);

        // Assert
        expect(reader.isCompleted, isTrue);
        expect(reader.sw, equals(0x9000));
        expect(reader.isOk, isTrue);
        expect(reader.data, equals(Uint8List.fromList([0xAA])));
        expect(reader.dataWithOffset, equals(Uint8List.fromList([])));
      });

      test('throws when bytes are too short', () {
        // Arrange
        final bytes = [0x00, 0x01, 0x02, 0x03]; // Only 4 bytes, need at least 5

        // Act & Assert
        expect(
          () => LedgerDataReader.fromBytes(bytes),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Data must be at least 5 bytes long',
            ),
          ),
        );
      });

      test('handles only status word', () {
        // Arrange: Valid structure with only SW, no data
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x02, 0x90, 0x00];

        // Act
        final reader = LedgerDataReader.fromBytes(bytes);

        // Assert
        expect(reader.isCompleted, isTrue);
        expect(reader.sw, equals(0x9000));
        expect(reader.isOk, isTrue);
        expect(reader.data, equals(Uint8List.fromList([])));
        // dataWithOffset will throw RangeError for empty data,
        // which is expected behavior
        expect(() => reader.dataWithOffset, throwsA(isA<RangeError>()));
      });
      test('handles error status word', () {
        // Arrange: Response with error status (0x6A80) and 1 data byte
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x03, 0xAA, 0x6A, 0x80];

        // Act
        final reader = LedgerDataReader.fromBytes(bytes);

        // Assert
        expect(reader.isCompleted, isTrue);
        expect(reader.sw, equals(0x6A80));
        expect(reader.isOk, isFalse);
        expect(reader.data, equals(Uint8List.fromList([0xAA])));
        expect(reader.dataWithOffset, equals(Uint8List.fromList([])));
      });

      test('handles large data payload', () {
        // Arrange: Large data payload (5 bytes + 2 SW bytes = 7 total)
        final dataBytes = [0xAA, 0xBB, 0xCC, 0xDD, 0xEE];
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x07, ...dataBytes, 0x90, 0x00];

        // Act
        final reader = LedgerDataReader.fromBytes(bytes);

        // Assert
        expect(reader.isCompleted, isTrue);
        expect(reader.sw, equals(0x9000));
        expect(reader.isOk, isTrue);
        expect(reader.data, equals(Uint8List.fromList(dataBytes)));
        expect(
          reader.dataWithOffset,
          equals(Uint8List.fromList(dataBytes.skip(1).toList())),
        );
      });
    });

    group('incremental data addition', () {
      test('can add data incrementally', () {
        // Arrange: Expect 6 bytes total (4 data + 2 SW)
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x06];
        final reader = LedgerDataReader.fromBytes(bytes);

        expect(reader.isCompleted, isFalse);

        // Act: Add data in chunks
        reader.add([0xAA, 0xBB]);
        expect(reader.isCompleted, isFalse);

        reader.add([0xCC, 0xDD]);
        expect(reader.isCompleted, isFalse);

        reader.add([0x90, 0x00]); // Complete with SW

        // Assert
        expect(reader.isCompleted, isTrue);
        expect(reader.sw, equals(0x9000));
        expect(reader.isOk, isTrue);
        expect(
          reader.data,
          equals(Uint8List.fromList([0xAA, 0xBB, 0xCC, 0xDD])),
        );
        expect(
          reader.dataWithOffset,
          equals(Uint8List.fromList([0xBB, 0xCC, 0xDD])),
        );
      });

      test('throws when adding too much data', () {
        // Arrange: Expect only 3 bytes total (1 data + 2 SW)
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x03];
        final reader = LedgerDataReader.fromBytes(bytes);

        // Act & Assert
        expect(
          () => reader.add([0xAA, 0xBB, 0xCC, 0xDD]), // 4 bytes > 3 expected
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Bytes exceeds the expected data length',
            ),
          ),
        );
      });

      test('throws when accessing bytes before completion', () {
        // Arrange: Expect 3 bytes but don't provide them
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x03];
        final reader = LedgerDataReader.fromBytes(bytes);

        // Act & Assert
        expect(
          () => reader.bytes,
          throwsA(
            isA<StateError>().having(
              (e) => e.message,
              'message',
              'Data is not complete yet',
            ),
          ),
        );

        expect(() => reader.sw, throwsA(isA<StateError>()));

        expect(() => reader.data, throwsA(isA<StateError>()));

        expect(() => reader.dataWithOffset, throwsA(isA<StateError>()));
      });
    });

    group('status word interpretation', () {
      test('correctly identifies success status', () {
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x03, 0xAA, 0x90, 0x00];
        final reader = LedgerDataReader.fromBytes(bytes);

        expect(reader.sw, equals(0x9000));
        expect(reader.isOk, isTrue);
      });

      test('correctly identifies various error statuses', () {
        final testCases = [
          (0x6A80, false), // Incorrect data
          (0x6A82, false), // File not found
          (0x6985, false), // Conditions not satisfied
          (0x6E00, false), // Class not supported
          (0x9001, false), // Custom status (not 0x9000)
        ];

        for (final (statusWord, expectedOk) in testCases) {
          final sw1 = (statusWord >> 8) & 0xFF;
          final sw2 = statusWord & 0xFF;
          final bytes = [0x00, 0x01, 0x02, 0x03, 0x03, 0xAA, sw1, sw2];
          final reader = LedgerDataReader.fromBytes(bytes);

          expect(reader.sw, equals(statusWord));
          expect(reader.isOk, equals(expectedOk));
        }
      });
    });

    group('edge cases', () {
      test('handles zero-length data', () {
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x02, 0x90, 0x00];
        final reader = LedgerDataReader.fromBytes(bytes);

        expect(reader.isCompleted, isTrue);
        expect(reader.data, equals(Uint8List.fromList([])));
        // dataWithOffset will throw RangeError for empty data,
        // which is expected behavior
        expect(() => reader.dataWithOffset, throwsA(isA<RangeError>()));
      });
      test('handles maximum practical data length', () {
        const dataLength = 253; // 253 data bytes + 2 SW bytes = 255 total
        final dataBytes = List.generate(dataLength, (i) => 0xFF);
        final bytes = [0x00, 0x01, 0x02, 0x03, 255, ...dataBytes, 0x90, 0x00];
        final reader = LedgerDataReader.fromBytes(bytes);

        expect(reader.isCompleted, isTrue);
        expect(reader.data.length, equals(dataLength));
        expect(reader.dataWithOffset.length, equals(dataLength - 1));
        expect(reader.data.every((b) => b == 0xFF), isTrue);
      });

      test('bytes property caches result', () {
        final bytes = [0x00, 0x01, 0x02, 0x03, 0x04, 0xAA, 0xBB, 0x90, 0x00];
        final reader = LedgerDataReader.fromBytes(bytes);

        final firstCall = reader.bytes;
        final secondCall = reader.bytes;

        expect(identical(firstCall, secondCall), isTrue);
      });
    });
  });
}
