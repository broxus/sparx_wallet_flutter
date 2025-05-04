import 'package:app/feature/browser_v2/data/browser_basic_auth_creds.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserAuthManager {
  final _basicAuthCreds = <String, BrowserBasicAuthCreds>{};

  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  ) {
    return _basicAuthCreds[_basicAuthCredsKey(challenge)];
  }

  Map<String, BrowserBasicAuthCreds> setBasicAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds creds,
  ) {
    return {
      ..._basicAuthCreds,
      _basicAuthCredsKey(challenge): creds,
    };
  }

  String _basicAuthCredsKey(URLAuthenticationChallenge challenge) =>
      '${challenge.protectionSpace.protocol}//'
      '${challenge.protectionSpace.host}:'
      '${challenge.protectionSpace.port}:'
      '${challenge.protectionSpace.realm}';
}
