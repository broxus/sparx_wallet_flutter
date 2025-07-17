import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:injectable/injectable.dart';

@singleton
class BlePacker {
  List<Uint8List> pack(Uint8List payload, int mtu) {
    final output = <Uint8List>[];
    var sequenceIdx = 0;
    var offset = 0;
    var first = true;
    var remainingBytes = payload.length;

    while (remainingBytes > 0) {
      final buffer = ByteDataWriter();
      var remainingSpaceInPacket = mtu - 3;

      // 0x05 Marks application specific data
      buffer
        ..writeUint8(0x05) // Command / DATA_CLA
        ..writeUint16(sequenceIdx); // packet sequence index

      // If this is the first packet, also encode the total message length
      if (first) {
        remainingSpaceInPacket -= 2;
        buffer.writeUint16(payload.length); // data length
        first = false;
      }

      remainingSpaceInPacket -= 3;
      final bytesToCopy = (remainingSpaceInPacket < remainingBytes)
          ? remainingSpaceInPacket
          : remainingBytes;

      remainingBytes -= bytesToCopy;

      // Copy some number of bytes into the packet
      buffer.write(
        payload.getRange(offset, offset + bytesToCopy).toList(),
      ); // payload

      sequenceIdx += 1;
      offset += bytesToCopy;
      output.add(buffer.toBytes());
    }

    return output;
  }
}
