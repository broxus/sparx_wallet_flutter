import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late BrowserBookmarksStorageService browserBookmarksStorageService;
  late MockGetStorage storage;

  setUp(() {
    storage = MockGetStorage();
    browserBookmarksStorageService = BrowserBookmarksStorageService(storage);
  });

  group('bookmarks', () {
    test('get empty bookmarks', () {
      when(
        () => storage.read<List<dynamic>>('browser_bookmarks_key'),
      ).thenReturn([]);
      final result = browserBookmarksStorageService.getBrowserBookmarks();

      expect(result, isEmpty);
    });

    test('get bookmarks', () {
      const id = '0';
      const title = 'Test title';
      const url = 'https://example.com';
      const sortingOrder = 1;

      when(
        () => storage.read<List<dynamic>>('browser_bookmarks_key'),
      ).thenReturn([
        {'id': id, 'title': title, 'url': url, 'sortingOrder': sortingOrder},
      ]);
      final result = browserBookmarksStorageService.getBrowserBookmarks();

      expect(result, hasLength(1));
      expect(result.first.id, id);
      expect(result.first.url, Uri.parse(url));
      expect(result.first.title, title);
      expect(result.first.sortingOrder, sortingOrder);
    });
  });
}
