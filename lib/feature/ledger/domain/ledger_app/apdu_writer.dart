import 'dart:typed_data';

import 'package:app/feature/ledger/ledger.dart';
import 'package:buffer/buffer.dart';

class APDUWriter extends ByteDataWriter {
  APDUWriter({
    required ApduIns ins,
    int cla = 0xe0, // default CLA for Ledger apps
    int p1 = 0x00,
    int p2 = 0x00,
  }) : super() {
    writeUint8(cla); // CLA
    writeUint8(ins.byte); // INS
    writeUint8(p1); // P1
    writeUint8(p2); // P2
  }

  void writeByteData(ByteData data) {
    writeUint8(data.lengthInBytes);
    write(data.buffer.asUint8List());
  }

  void writeData(Uint8List data) {
    writeUint8(data.lengthInBytes);
    write(data);
  }
}
