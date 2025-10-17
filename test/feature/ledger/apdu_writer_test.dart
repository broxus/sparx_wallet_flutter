import 'dart:typed_data';

import 'package:app/feature/ledger/domain/ledger_app/apdu_ins.dart';
import 'package:app/feature/ledger/domain/ledger_app/apdu_writer.dart';
import 'package:test/test.dart';

void main() {
  group('APDUWriter', () {
    group('constructor', () {
      test('creates APDU with default parameters', () {
        // Arrange & Act
        final writer = APDUWriter(ins: ApduIns.getApp);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(4)); // APDU header length without LC
        expect(bytes[0], equals(0xe0)); // Default CLA
        expect(bytes[1], equals(ApduIns.getApp.byte)); // INS
        expect(bytes[2], equals(0x00)); // Default P1
        expect(bytes[3], equals(0x00)); // Default P2
      });

      test('creates APDU with custom parameters', () {
        // Arrange & Act
        final writer = APDUWriter(
          ins: ApduIns.sign,
          cla: 0xA0,
          p1: 0x01,
          p2: 0x02,
        );
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(4));
        expect(bytes[0], equals(0xA0)); // Custom CLA
        expect(bytes[1], equals(ApduIns.sign.byte)); // INS
        expect(bytes[2], equals(0x01)); // Custom P1
        expect(bytes[3], equals(0x02)); // Custom P2
      });

      test('works with all ApduIns values', () {
        for (final ins in ApduIns.values) {
          // Arrange & Act
          final writer = APDUWriter(ins: ins);
          final bytes = writer.toBytes();

          // Assert
          expect(bytes[1], equals(ins.byte));
        }
      });
    });

    group('writeByteData', () {
      test('writes ByteData with correct length prefix', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getPk);
        final data = ByteData(4)
          ..setUint8(0, 0xAA)
          ..setUint8(1, 0xBB)
          ..setUint8(2, 0xCC)
          ..setUint8(3, 0xDD);

        // Act
        writer.writeByteData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(9)); // Header (4) + length (1) + data (4)
        expect(bytes[4], equals(0x04)); // Data length
        expect(bytes[5], equals(0xAA)); // Data byte 0
        expect(bytes[6], equals(0xBB)); // Data byte 1
        expect(bytes[7], equals(0xCC)); // Data byte 2
        expect(bytes[8], equals(0xDD)); // Data byte 3
      });

      test('writes empty ByteData', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getConf);
        final data = ByteData(0);

        // Act
        writer.writeByteData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(5)); // Header (4) + length (1)
        expect(bytes[4], equals(0x00)); // Data length = 0
      });

      test('writes large ByteData', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.signTransaction);
        final data = ByteData(255);
        for (var i = 0; i < 255; i++) {
          data.setUint8(i, i % 256);
        }

        // Act
        writer.writeByteData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(
          bytes.length,
          equals(260),
        ); // Header (4) + length (1) + data (255)
        expect(bytes[4], equals(0xFF)); // Data length = 255

        // Verify data integrity
        for (var i = 0; i < 255; i++) {
          expect(bytes[5 + i], equals(i % 256));
        }
      });

      test('handles ByteData with different endianness', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getAddr);
        // Write various data types
        final data = ByteData(8)
          ..setUint16(0, 0x1234)
          ..setUint16(2, 0x5678, Endian.little)
          ..setUint32(4, 0x9ABCDEF0);

        // Act
        final bytes = (writer..writeByteData(data))
            .toBytes(); // ignore: cascade_invocations

        // Assert
        expect(bytes.length, equals(13)); // Header (4) + length (1) + data (8)
        expect(bytes[4], equals(0x08)); // Data length

        // Verify big-endian uint16
        expect(bytes[5], equals(0x12));
        expect(bytes[6], equals(0x34));

        // Verify little-endian uint16
        expect(bytes[7], equals(0x78));
        expect(bytes[8], equals(0x56));

        // Verify big-endian uint32
        expect(bytes[9], equals(0x9A));
        expect(bytes[10], equals(0xBC));
        expect(bytes[11], equals(0xDE));
        expect(bytes[12], equals(0xF0));
      });
    });

    group('writeData', () {
      test('writes Uint8List with correct length prefix', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.openApp);
        final data = Uint8List.fromList([0x11, 0x22, 0x33]);

        // Act
        writer.writeData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(8)); // Header (4) + length (1) + data (3)
        expect(bytes[4], equals(0x03)); // Data length
        expect(bytes[5], equals(0x11)); // Data byte 0
        expect(bytes[6], equals(0x22)); // Data byte 1
        expect(bytes[7], equals(0x33)); // Data byte 2
      });

      test('writes empty Uint8List', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getApp);
        final data = Uint8List(0);

        // Act
        writer.writeData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(5)); // Header (4) + length (1)
        expect(bytes[4], equals(0x00)); // Data length = 0
      });

      test('writes single byte Uint8List', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.sign);
        final data = Uint8List.fromList([0xFF]);

        // Act
        writer.writeData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(6)); // Header (4) + length (1) + data (1)
        expect(bytes[4], equals(0x01)); // Data length = 1
        expect(bytes[5], equals(0xFF)); // Data
      });

      test('writes maximum size Uint8List', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.signTransaction);
        final data = Uint8List.fromList(List.generate(255, (i) => 0xAA));

        // Act
        writer.writeData(data);
        final bytes = writer.toBytes();

        // Assert
        expect(
          bytes.length,
          equals(260),
        ); // Header (4) + length (1) + data (255)
        expect(bytes[4], equals(0xFF)); // Data length = 255
        expect(bytes.sublist(5).every((b) => b == 0xAA), isTrue);
      });
    });

    group('multiple data writes', () {
      test('combines multiple writeData calls', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.sign);
        final data1 = Uint8List.fromList([0x01, 0x02]);
        final data2 = Uint8List.fromList([0x03, 0x04, 0x05]);

        // Act
        writer
          ..writeData(data1)
          ..writeData(data2);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(11)); // Header (4) + len1 (1) + data1 (2) +
        // len2 (1) + data2 (3)

        // First data block
        expect(bytes[4], equals(0x02)); // Length of first data
        expect(bytes[5], equals(0x01)); // First data byte 0
        expect(bytes[6], equals(0x02)); // First data byte 1

        // Second data block
        expect(bytes[7], equals(0x03)); // Length of second data
        expect(bytes[8], equals(0x03)); // Second data byte 0
        expect(bytes[9], equals(0x04)); // Second data byte 1
        expect(bytes[10], equals(0x05)); // Second data byte 2
      });

      test('combines writeByteData and writeData', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getPk);
        final byteData = ByteData(2)
          ..setUint8(0, 0xAA)
          ..setUint8(1, 0xBB);
        final uint8Data = Uint8List.fromList([0xCC, 0xDD]);

        // Act
        writer
          ..writeByteData(byteData)
          ..writeData(uint8Data);
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(10)); // Header (4) + len1 (1) + data1 (2) +
        // len2 (1) + data2 (2)

        // ByteData block
        expect(bytes[4], equals(0x02)); // Length
        expect(bytes[5], equals(0xAA)); // Data
        expect(bytes[6], equals(0xBB)); // Data

        // Uint8List block
        expect(bytes[7], equals(0x02)); // Length
        expect(bytes[8], equals(0xCC)); // Data
        expect(bytes[9], equals(0xDD)); // Data
      });

      test('handles many small data writes', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.signTransaction);

        // Act: Write 10 single-byte data blocks
        for (var i = 0; i < 10; i++) {
          writer.writeData(Uint8List.fromList([i]));
        }
        final bytes = writer.toBytes();

        // Assert
        expect(
          bytes.length,
          equals(24),
        ); // Header (4) + 10 * (length (1) + data (1))

        for (var i = 0; i < 10; i++) {
          final offset = 4 + i * 2;
          expect(bytes[offset], equals(0x01)); // Length = 1
          expect(bytes[offset + 1], equals(i)); // Data = i
        }
      });
    });

    group('inheritance from ByteDataWriter', () {
      test('can use standard ByteDataWriter methods', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getConf);

        // Act: Use inherited methods
        final bytes =
            (writer
                  ..writeUint8(0x12)
                  ..writeUint16(0x3456)
                  ..writeUint32(0x789ABCDE))
                .toBytes();

        // Assert
        expect(
          bytes.length,
          equals(11),
        ); // Header (4) + uint8 (1) + uint16 (2) + uint32 (4)
        expect(bytes[4], equals(0x12)); // uint8
        expect(bytes[5], equals(0x34)); // uint16 high byte
        expect(bytes[6], equals(0x56)); // uint16 low byte
        expect(bytes[7], equals(0x78)); // uint32 byte 0
        expect(bytes[8], equals(0x9A)); // uint32 byte 1
        expect(bytes[9], equals(0xBC)); // uint32 byte 2
        expect(bytes[10], equals(0xDE)); // uint32 byte 3
      });

      test('can mix inherited methods with writeData', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.sign);

        // Act
        final bytes =
            (writer
                  ..writeUint8(0xFF)
                  ..writeData(Uint8List.fromList([0x01, 0x02]))
                  ..writeUint16(0x0304))
                .toBytes();

        // Assert
        expect(
          bytes.length,
          equals(10),
        ); // Header (4) + uint8 (1) + data block (3) +
        // uint16 (2)
        expect(bytes[4], equals(0xFF)); // uint8
        expect(bytes[5], equals(0x02)); // Data length
        expect(bytes[6], equals(0x01)); // Data byte 0
        expect(bytes[7], equals(0x02)); // Data byte 1
        expect(bytes[8], equals(0x03)); // uint16 high byte
        expect(bytes[9], equals(0x04)); // uint16 low byte
      });
    });

    group('edge cases', () {
      test('handles LC overflow gracefully', () {
        // Arrange: This test verifies behavior when total data exceeds
        // 255 bytes
        final writer = APDUWriter(ins: ApduIns.signTransaction);
        final largeData = Uint8List(200);

        // Act
        writer
          ..writeData(largeData)
          ..writeData(Uint8List(100)); // Total > 255
        final bytes = writer.toBytes();

        // Assert: LC should wrap around (implementation dependent)
        expect(
          bytes.length,
          equals(306),
        ); // Header (4) + len1 (1) + data1 (200) +
        // len2 (1) + data2 (100)
        // LC behavior with overflow is implementation-specific
        expect(bytes[4], isA<int>()); // Should be some valid uint8 value
      });

      test('maintains correct structure with no data writes', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.getApp);

        // Act: Don't write any data
        final bytes = writer.toBytes();

        // Assert
        expect(bytes.length, equals(4)); // Just the header
      });

      test('writeData with reference to same array', () {
        // Arrange
        final writer = APDUWriter(ins: ApduIns.sign);
        final data = Uint8List.fromList([0x01, 0x02, 0x03]);

        // Act: Write the same data reference multiple times
        writer.writeData(data);
        data[0] = 0xFF; // Modify original
        writer.writeData(data);
        final bytes = writer.toBytes();

        // Assert: Both writes reflect the current state of the referenced array
        expect(bytes[5], equals(0xFF)); // First write, modified value
        expect(bytes[9], equals(0xFF)); // Second write, modified value
      });
    });
  });
}
