import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

String? getQueryParams(GoRouterState state, String key) {
  return state.uri.queryParameters[key];
}

abstract class UrlValidator {
  static final _urlReg = RegExp(
    r'^(https?|ftp):\/\/[^\s\/$.?#].[^\s]*$|^(www\.)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}([\/\w .-]*)*\/?$',
  );

  static bool checkUri(Uri uri) {
    return checkString(uri.toString());
  }

  static bool checkString(String text) {
    try {
      return _urlReg.hasMatch(text);
    } catch (_) {
      return false;
    }
  }
}

Uri? parseUriOrNull([
  String? uri,
  int start = 0,
  int? end,
]) {
  try {
    return uri == null
        ? null
        : Uri.parse(
            uri,
            start,
            end,
          );
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);
    return null;
  }
}
