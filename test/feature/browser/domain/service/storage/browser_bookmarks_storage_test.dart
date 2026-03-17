import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/feature/browser/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAdapter extends Mock implements StorageAdapter {}

class MockStorageBox extends Mock implements StorageBox {}

void main() {
  late BrowserBookmarksStorageService browserBookmarksStorageService;
  late MockStorageAdapter storageAdapter;
  late MockStorageBox storageBox;

  setUp(() {
    storageAdapter = MockStorageAdapter();
    storageBox = MockStorageBox();
    when(
      () => storageAdapter.box(BrowserBookmarksStorageService.container),
    ).thenReturn(storageBox);
    browserBookmarksStorageService = BrowserBookmarksStorageService(
      storageAdapter,
    );
  });

  group('bookmarks', () {
    test('get empty bookmarks', () {
      when(
        () => storageBox.read<List<dynamic>>('browser_bookmarks_key'),
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
        () => storageBox.read<List<dynamic>>('browser_bookmarks_key'),
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
