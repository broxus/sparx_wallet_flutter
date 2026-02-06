import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

List<T> castJsonList<T>(dynamic json) {
  if (json == null) {
    return [];
  }
  try {
    return (json as List<dynamic>).cast<T>();
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    return [];
  }
}

Map<String, dynamic> castJsonMap(dynamic json) {
  if (json == null) {
    return {};
  }
  return castTo<Map<String, dynamic>>(json) ?? {};
}

T? castTo<T>(dynamic data) {
  if (data == null) {
    return null;
  }

  try {
    return data as T;
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    return null;
  }
}

String? castToString(dynamic data) => castTo<String>(data);

/// JSON converter for epoch timestamps that may be in seconds or milliseconds.
///
/// This converter normalizes different epoch formats commonly returned by APIs:
/// - Values **>= 100,000,000,000** (1e11) are treated as **milliseconds since epoch**
///   and converted to seconds by dividing by 1000.
/// - Values **< 100,000,000,000** are treated as **seconds since epoch** and
///   returned as-is.
///
/// Using this converter on timestamp fields helps when API responses are
/// inconsistent or change over time between seconds and milliseconds.
class EpochSecondsConverter implements JsonConverter<int?, Object?> {
  const EpochSecondsConverter();

  @override
  int? fromJson(Object? json) {
    if (json == null) return null;

    final value = switch (json) {
      final int i => BigInt.from(i),
      final num n => BigInt.from(n.toInt()),
      final String s => BigInt.tryParse(s),
      _ => null,
    };

    if (value == null) return null;

    if (value >= BigInt.from(100000000000)) {
      return (value ~/ BigInt.from(1000)).toInt();
    }

    return value.toInt();
  }

  @override
  int? toJson(int? object) => object;
}
