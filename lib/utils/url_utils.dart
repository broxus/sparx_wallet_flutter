import 'package:go_router/go_router.dart';

String? getQueryParams(GoRouterState state, String key) {
  return state.uri.queryParameters[key];
}

abstract class UrlValidator {
  static final _urlReg = RegExp(
      r'(^(https?|ftp):\/\/).*|^(www\.)([\w\/\-#=@:+~%\.]+)(\.\w{2,})|^(?!www\.)([\w\/\-#=@:+~%\.]+)(\.\w{2,})');

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
