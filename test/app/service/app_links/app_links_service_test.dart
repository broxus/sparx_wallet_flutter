import 'dart:async';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app_links_platform_interface/app_links_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAppLinksPlatform extends AppLinksPlatform {
  FakeAppLinksPlatform({this.initialLink});

  final StreamController<Uri> _uriCtrl = StreamController<Uri>.broadcast();
  Uri? initialLink;

  @override
  Stream<Uri> get uriLinkStream => _uriCtrl.stream;

  @override
  Stream<String> get stringLinkStream =>
      _uriCtrl.stream.map((u) => u.toString());

  void emitUri(Uri uri) => _uriCtrl.add(uri);

  Future<void> dispose() async => _uriCtrl.close();

  @override
  Future<Uri?> getInitialLink() async => initialLink;

  @override
  Future<String?> getInitialLinkString() async => initialLink?.toString();

  @override
  Future<Uri?> getLatestLink() async => null;

  @override
  Future<String?> getLatestLinkString() async => null;
}

class _ThrowingInitialLinkPlatform extends FakeAppLinksPlatform {
  _ThrowingInitialLinkPlatform();

  @override
  Future<Uri?> getInitialLink() async => throw Exception('boom');

  @override
  Future<String?> getInitialLinkString() async => throw Exception('boom');

  @override
  Future<Uri?> getLatestLink() async => null;

  @override
  Future<String?> getLatestLinkString() async => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeAppLinksPlatform platform;
  late AppLinksService service;

  setUp(() {
    platform = FakeAppLinksPlatform();
    AppLinksPlatform.instance = platform;

    service = AppLinksService();
  });

  tearDown(() async {
    service.dispose();
    await platform.dispose();
  });

  group('Valid link', () {
    test('query link: http/https -> true', () {
      final uri = Uri.parse('any://x?link=https%3A%2F%2Fexample.com%2Fpath');
      expect(service.isValidAppLink(uri), isTrue);
    });

    test('query link: non-http -> false', () {
      final uri = Uri.parse('any://x?link=ftp%3A%2F%2Fexample.com');
      expect(service.isValidAppLink(uri), isFalse);
    });

    test('tc scheme -> true', () {
      final uri = Uri.parse('tc://?anything=1');
      expect(service.isValidAppLink(uri), isTrue);
    });

    test('host l.sparxwallet.com -> true', () {
      final uri = Uri.parse('https://l.sparxwallet.com/some/path?x=1');
      expect(service.isValidAppLink(uri), isTrue);
    });

    test('random uri -> false', () {
      final uri = Uri.parse('myapp://example.com/abc');
      expect(service.isValidAppLink(uri), isFalse);
    });
  });

  group('handleAppLink via subscription', () {
    test('emits BrowserAppLinksData for ?link=https://...', () async {
      final future = service.browserLinksStream.first;

      platform.emitUri(
        Uri.parse('any://x?link=https%3A%2F%2Fexample.com%2Fpath'),
      );

      final event = await future;
      expect(event, isA<BrowserAppLinksData>());
      expect(event.url, Uri.parse('https://example.com/path'));
    });

    test('does NOT emit BrowserAppLinksData when link is empty', () async {
      final events = <BrowserAppLinksData>[];
      final sub = service.browserLinksStream.listen(events.add);
      addTearDown(sub.cancel);

      platform.emitUri(Uri.parse('any://x?link='));

      await pumpEventQueue();

      expect(events, isEmpty);
    });

    test(
      'does not emit BrowserAppLinksData when link is not allowed scheme',
      () async {
        final events = <BrowserAppLinksData>[];
        final sub = service.browserLinksStream.listen(events.add);
        addTearDown(sub.cancel);

        platform.emitUri(Uri.parse('any://x?link=ftp%3A%2F%2Fexample.com'));

        await pumpEventQueue();

        expect(events, isEmpty);
      },
    );

    test(
      'tc:// with invalid query does NOT emit TonConnectAppLinksData',
      () async {
        final events = <TonConnectAppLinksData>[];
        final sub = service.tonConnecLinksData.listen(events.add);
        addTearDown(sub.cancel);

        platform.emitUri(Uri.parse('tc://?bad=1'));

        await pumpEventQueue();

        expect(events, isEmpty);
      },
    );

    test('tc:// valid query emits TonConnectAppLinksData', () async {
      // Arrange
      final future = service.tonConnecLinksData.first;

      // Act
      platform.emitUri(
        Uri.parse(
          'tc://?v=2'
          '&id=some_id'
          '&r=some_r'
          '&ret=none',
        ),
      );

      final event = await future;
      expect(event, isA<TonConnectAppLinksData>());
    });

    test(
      'l.sparxwallet.com valid query emits TonConnectAppLinksData',
      () async {
        final future = service.tonConnecLinksData.first;

        platform.emitUri(
          Uri.parse(
            'https://l.sparxwallet.com/anything'
            '?v=2'
            '&id=some_id'
            '&r=some_r'
            '&ret=none',
          ),
        );

        final event = await future;
        expect(event, isA<TonConnectAppLinksData>());
      },
    );
  });

  group('handle initial link', () {
    test('non-null initial link is handled (BrowserAppLinksData)', () async {
      platform.initialLink = Uri.parse(
        'any://x?link=https%3A%2F%2Fexample.com%2Finitial',
      );

      final future = service.browserLinksStream.first;

      await service.handleInitialLink();

      final event = await future;
      expect(event, isA<BrowserAppLinksData>());
      expect(event.url, Uri.parse('https://example.com/initial'));
    });

    test('null initial link -> no events', () async {
      platform.initialLink = null;

      final events = <BrowserAppLinksData>[];
      final sub = service.browserLinksStream.listen(events.add);
      addTearDown(sub.cancel);

      await service.handleInitialLink();

      await pumpEventQueue();

      expect(events, isEmpty);
    });

    test('getInitialLink throws -> ignored (no crash, no events)', () async {
      final throwingPlatform = _ThrowingInitialLinkPlatform();
      AppLinksPlatform.instance = throwingPlatform;
      final localService = AppLinksService();
      addTearDown(localService.dispose);
      addTearDown(() async => throwingPlatform.dispose());

      final events = <BrowserAppLinksData>[];
      final sub = localService.browserLinksStream.listen(events.add);
      addTearDown(sub.cancel);

      await localService.handleInitialLink();

      await pumpEventQueue();

      expect(events, isEmpty);
    });
  });

  group('dispose', () {
    test('after dispose, incoming links are not handled anymore', () async {
      service.dispose();

      final events = <BrowserAppLinksData>[];
      final sub = service.browserLinksStream.listen(events.add);
      addTearDown(sub.cancel);

      platform.emitUri(
        Uri.parse('any://x?link=https%3A%2F%2Fexample.com%2Fafter_dispose'),
      );

      await pumpEventQueue();

      expect(events, isEmpty);
    });
  });
}
