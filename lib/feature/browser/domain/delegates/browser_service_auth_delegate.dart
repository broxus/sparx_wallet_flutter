import 'package:app/feature/browser/data/browser_basic_auth_creds.dart';
import 'package:app/feature/browser/domain/delegates/browser_base_delegate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';

abstract interface class BrowserServiceAuth {
  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  );

  Map<String, BrowserBasicAuthCreds> setBasicAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds creds,
  );
}

@injectable
class BrowserServiceAuthDelegate
    implements BrowserDelegate, BrowserServiceAuth {
  final _basicAuthCreds = <String, BrowserBasicAuthCreds>{};

  @override
  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  ) {
    return _basicAuthCreds[_basicAuthCredsKey(challenge)];
  }

  @override
  Map<String, BrowserBasicAuthCreds> setBasicAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds creds,
  ) {
    _basicAuthCreds[_basicAuthCredsKey(challenge)] = creds;

    return _basicAuthCreds;
  }

  String _basicAuthCredsKey(URLAuthenticationChallenge challenge) =>
      '${challenge.protectionSpace.protocol}//'
      '${challenge.protectionSpace.host}:'
      '${challenge.protectionSpace.port}:'
      '${challenge.protectionSpace.realm}';
}
