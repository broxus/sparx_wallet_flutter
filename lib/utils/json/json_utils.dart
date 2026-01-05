import 'package:flutter/cupertino.dart';

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
