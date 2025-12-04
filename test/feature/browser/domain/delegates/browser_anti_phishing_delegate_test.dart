import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/resources_service.dart';
import 'package:app/feature/browser/domain/delegates/browser_anti_phishing_delegate.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockResourcesService extends Mock implements ResourcesService {}

void main() {
  late MockResourcesService resourcesService;
  late BrowserAntiPhishingDelegate delegate;

  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    resourcesService = MockResourcesService();
    delegate = BrowserAntiPhishingDelegate(resourcesService);
  });

  group('Test url', () {
    test('Load url from blacklist', () async {
      const json = '{"blacklist": ["evil.com"]}';

      when(
        () => resourcesService.loadString('assets/configs/anti_phishing.json'),
      ).thenAnswer((_) async => json);

      await delegate.init();

      final uri = Uri.parse('https://www.evil.com/path/#section');

      final result = delegate.checkIsPhishingUri(uri);

      expect(result, isTrue);
    });

    test('Load url from blacklist with pattern', () async {
      const json = '{"blacklist": ["*.example.com"]}';

      when(
        () => resourcesService.loadString('assets/configs/anti_phishing.json'),
      ).thenAnswer((_) async => json);

      await delegate.init();

      final bad = Uri.parse('https://sub.example.com/login');
      final ok = Uri.parse('https://example.org/');

      expect(delegate.checkIsPhishingUri(bad), isTrue);
      expect(delegate.checkIsPhishingUri(ok), isFalse);
    });

    test('Load url from whitelist', () async {
      const json = '{"blacklist": ["evil.com"]}';

      when(
        () => resourcesService.loadString('assets/configs/anti_phishing.json'),
      ).thenAnswer((_) async => json);

      await delegate.init();

      final uri = Uri.parse('https://evil.com/');

      expect(delegate.checkIsPhishingUri(uri), isTrue);

      delegate.addToWhiteList('https://evil.com/');

      expect(delegate.checkIsPhishingUri(uri), isFalse);
    });
  });

  group('getPhishingGuardHtml', () {
    testWidgets('Load template html from cache', (tester) async {
      const template = '<html>{PHISHING_ORIGINAL_SITE}</html>';

      tester.binding.defaultBinaryMessenger.setMockMessageHandler(
        'flutter/assets',
        (ByteData? message) async {
          if (message == null) return null;

          final key = utf8.decode(message.buffer.asUint8List());
          if (key == 'assets/html/anti_phishing.html') {
            final bytes = utf8.encode(template);
            final buffer = Uint8List.fromList(bytes).buffer;
            return ByteData.view(buffer);
          }

          return null;
        },
      );

      final uri = Uri.parse('https://evil.com/path');

      final first = await delegate.getPhishingGuardHtml(uri);
      final second = await delegate.getPhishingGuardHtml(uri);

      expect(first, '<html>https://evil.com/path</html>');
      expect(second, first);
    });
  });

  group('addToWhiteList', () {
    test('Add url to whitelist', () async {
      const json = '{"blacklist": ["evil.com"]}';

      when(
        () => resourcesService.loadString('assets/configs/anti_phishing.json'),
      ).thenAnswer((_) async => json);

      await delegate.init();

      final uri = Uri.parse('https://www.evil.com/');

      expect(delegate.checkIsPhishingUri(uri), isTrue);

      delegate.addToWhiteList('https://www.evil.com/');

      expect(delegate.checkIsPhishingUri(uri), isFalse);
    });
  });

  group('dispose', () {
    test('Clear data', () async {
      const json = '{"blacklist": ["evil.com"]}';

      when(
        () => resourcesService.loadString('assets/configs/anti_phishing.json'),
      ).thenAnswer((_) async => json);

      await delegate.init();

      final uri = Uri.parse('https://evil.com/');

      expect(delegate.checkIsPhishingUri(uri), isTrue);

      delegate.dispose();

      expect(delegate.checkIsPhishingUri(uri), isFalse);
    });
  });
}
