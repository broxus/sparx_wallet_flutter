import 'package:app/feature/browser/domain/delegates/browser_service_favicon_delegate.dart';
import 'package:app/feature/browser/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBrowserFaviconURLStorageService extends Mock
    implements BrowserFaviconURLStorageService {}

void main() {
  late MockBrowserFaviconURLStorageService storage;
  late BrowserServiceFaviconDelegate delegate;

  setUp(() {
    storage = MockBrowserFaviconURLStorageService();
    delegate = BrowserServiceFaviconDelegate(storage);
  });

  group('getFaviconURL', () {
    test('Get favicon for url from storage', () async {
      final uri = Uri.parse('https://example.com');
      const faviconUrl = 'https://example.com/favicon.ico';

      when(
        () => storage.getFaviconURL(uri.toString()),
      ).thenAnswer((_) async => faviconUrl);

      final result = await delegate.getFaviconURL(uri);

      expect(result, faviconUrl);

      verify(() => storage.getFaviconURL(uri.toString())).called(1);
      verifyNever(() => storage.saveFaviconUrl(any(), any()));
    });

    test('Get favicon for url from cache', () async {
      final uri = Uri.parse('https://example.com');
      const faviconUrl = 'https://example.com/favicon.ico';

      when(
        () => storage.getFaviconURL(uri.toString()),
      ).thenAnswer((_) async => faviconUrl);

      final first = await delegate.getFaviconURL(uri);
      expect(first, faviconUrl);

      final second = await delegate.getFaviconURL(uri);
      expect(second, faviconUrl);

      verify(() => storage.getFaviconURL(uri.toString())).called(1);
      verifyNever(() => storage.saveFaviconUrl(any(), any()));
    });
  });
}
