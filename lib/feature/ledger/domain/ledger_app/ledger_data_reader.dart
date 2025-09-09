import 'dart:typed_data';

import 'package:buffer/buffer.dart';

const _swOk = 0x9000;
const _swCanceled = 0x6985; // Operation cancelled by user

abstract class LedgerResponse {
  /// Status word indicating the result of the operation.
  /// A value of 0x9000 indicates success.
  int get sw;

  /// Indicates whether the operation was successful.
  /// Returns true if the status word is 0x9000, false otherwise.
  bool get isOk => sw == _swOk;

  /// Indicates whether the operation was cancelled by the user.
  /// Returns true if the status word is 0x6985, false otherwise.
  bool get isCanceled => sw == _swCanceled;

  /// The data returned by the Ledger app.
  Uint8List get data;

  /// The data returned by the Ledger app, excluding the first byte.
  /// In most cases, this is the actual response data. First byte indicates the
  /// data length.
  Uint8List get dataWithOffset;
}

class LedgerDataReader extends LedgerResponse {
  LedgerDataReader._(this._dataLength);

  factory LedgerDataReader.fromBytes(List<int> bytes) {
    if (bytes.length < 5) {
      throw ArgumentError('Data must be at least 5 bytes long');
    }

    final dataLength = bytes[4];
    final data = bytes.sublist(5);

    return LedgerDataReader._(dataLength)..add(data);
  }

  final _buffer = BytesBuffer();
  final int _dataLength;
  Uint8List? _bytes;

  @override
  int get sw => bytes.buffer.asByteData(bytes.length - 2).getUint16(0);

  @override
  Uint8List get data => bytes.sublist(0, bytes.length - 2);

  @override
  Uint8List get dataWithOffset => bytes.sublist(1, bytes.length - 2);

  bool get isCompleted => _buffer.length == _dataLength;

  Uint8List get bytes {
    if (!isCompleted) {
      throw StateError('Data is not complete yet');
    }

    return _bytes ??= _buffer.toBytes();
  }

  void add(List<int> bytes) {
    if (_buffer.length + bytes.length > _dataLength) {
      throw ArgumentError('Bytes exceeds the expected data length');
    }

    _buffer.add(bytes);
  }
}
