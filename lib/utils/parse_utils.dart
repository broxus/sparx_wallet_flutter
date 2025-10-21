import 'package:flutter/foundation.dart';

double? parseToDouble(dynamic input) {
  try {
    if (input == null) return null;
    if (input is double) return input;
    if (input is int) return input.toDouble();
    if (input is String) return double.tryParse(input);

    return null;
  } catch (e) {
    return null;
  }
}

int? parseToInt(dynamic input) {
  try {
    if (input == null) return null;
    if (input is int) return input;
    if (input is double) return input.toInt();
    if (input is String) return int.tryParse(input);

    return null;
  } catch (e) {
    return null;
  }
}

BigInt? parseBigIntOrNull(dynamic source, {int? radix}) {
  try {
    if (source == null) return null;
    if (source is BigInt) return source;
    if (source is int) return BigInt.from(source);
    if (source is num) return BigInt.from(source.toInt());
    if (source is String) return BigInt.tryParse(source, radix: radix);
    return null;
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    return null;
  }
}
