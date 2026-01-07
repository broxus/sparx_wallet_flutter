import 'package:app/feature/browser/data/browser_basic_auth_creds.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_auth_delegate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_test/flutter_test.dart';

class MockProtectionSpace extends Fake implements URLProtectionSpace {
  MockProtectionSpace({
    required this.protocolValue,
    required this.hostValue,
    required this.portValue,
    required this.realmValue,
  });

  final String protocolValue;
  final String hostValue;
  final int portValue;
  final String realmValue;

  @override
  String? get protocol => protocolValue;

  @override
  String get host => hostValue;

  @override
  int? get port => portValue;

  @override
  String? get realm => realmValue;
}

class MockAuthenticationChallenge extends Fake
    implements URLAuthenticationChallenge {
  MockAuthenticationChallenge(this._protectionSpace);

  final URLProtectionSpace _protectionSpace;

  @override
  URLProtectionSpace get protectionSpace => _protectionSpace;
}

void main() {
  late BrowserServiceAuthDelegate delegate;
  late URLAuthenticationChallenge challenge;
  late BrowserBasicAuthCreds creds;

  setUp(() {
    delegate = BrowserServiceAuthDelegate();

    final protectionSpace = MockProtectionSpace(
      protocolValue: 'https',
      hostValue: 'example.com',
      portValue: 443,
      realmValue: 'MyRealm',
    );

    challenge = MockAuthenticationChallenge(protectionSpace);

    creds = const BrowserBasicAuthCreds(username: 'user', password: 'pass');
  });

  group('getBasicAuthCreds', () {
    test('No creds in cache', () {
      final result = delegate.getBasicAuthCreds(challenge);

      expect(result, isNull);
    });
  });

  group('setBasicAuthCreds', () {
    test('Save creds', () {
      final map = delegate.setBasicAuthCreds(challenge, creds);

      final stored = delegate.getBasicAuthCreds(challenge);
      expect(stored, isNotNull);
      expect(stored, same(creds));

      expect(map.length, 1);
      expect(map.values.single, same(creds));
    });

    test('Rewrite creds', () {
      const first = BrowserBasicAuthCreds(username: 'user1', password: 'pass1');
      const second = BrowserBasicAuthCreds(
        username: 'user2',
        password: 'pass2',
      );

      delegate
        ..setBasicAuthCreds(challenge, first)
        ..setBasicAuthCreds(challenge, second);

      final stored = delegate.getBasicAuthCreds(challenge);
      expect(stored, isNotNull);
      expect(stored, same(second));
    });

    test('Different protectionSpace', () {
      final otherProtectionSpace = MockProtectionSpace(
        protocolValue: 'https',
        hostValue: 'example.com',
        portValue: 443,
        realmValue: 'OtherRealm',
      );
      final otherChallenge = MockAuthenticationChallenge(otherProtectionSpace);

      const creds0 = BrowserBasicAuthCreds(
        username: 'user0',
        password: 'pass0',
      );
      const creds1 = BrowserBasicAuthCreds(
        username: 'user1',
        password: 'pass1',
      );

      delegate.setBasicAuthCreds(challenge, creds0);
      final map = delegate.setBasicAuthCreds(otherChallenge, creds1);

      expect(map.length, 2);

      final stored1 = delegate.getBasicAuthCreds(challenge);
      final stored2 = delegate.getBasicAuthCreds(otherChallenge);

      expect(stored1, same(creds0));
      expect(stored2, same(creds1));
    });
  });
}
