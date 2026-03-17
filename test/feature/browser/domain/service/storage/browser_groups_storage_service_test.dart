import 'package:app/app/service/ntp_service.dart';
import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/feature/browser/domain/service/storages/browser_groups_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageAdapter extends Mock implements StorageAdapter {}

class MockStorageBox extends Mock implements StorageBox {}

class MockNtpService extends Mock implements NtpService {}

void main() {
  late BrowserGroupsStorageService browserGroupsStorageService;
  late MockStorageAdapter storageAdapter;
  late MockStorageBox storageBox;
  late MockNtpService ntpService;

  final getIt = GetIt.instance;

  final now = DateTime.now();

  setUp(() async {
    await getIt.reset();
    ntpService = MockNtpService();
    storageAdapter = MockStorageAdapter();
    storageBox = MockStorageBox();

    getIt.registerSingleton<NtpService>(ntpService);

    when(
      () => storageAdapter.box(BrowserGroupsStorageService.container),
    ).thenReturn(storageBox);
    browserGroupsStorageService = BrowserGroupsStorageService(storageAdapter);

    when(() => ntpService.now()).thenReturn(now);
  });

  group('groups', () {
    test('get empty groups', () {
      when(
        () => storageBox.read<List<dynamic>>(
          BrowserGroupsStorageService.browserGroupsKey,
        ),
      ).thenReturn([]);

      final result = browserGroupsStorageService.getGroups();

      expect(result, isEmpty);
    });

    test('get groups', () {
      const id = '0';
      const title = 'Test title';
      const sortingOrder = 1;
      const tabsIds = ['0'];
      const isEditable = true;

      when(
        () => storageBox.read<List<dynamic>>(
          BrowserGroupsStorageService.browserGroupsKey,
        ),
      ).thenReturn([
        {
          'id': id,
          'title': title,
          'sortingOrder': sortingOrder,
          'tabsIds': tabsIds,
          'isEditable': isEditable,
        },
      ]);
      final result = browserGroupsStorageService.getGroups();

      expect(result, hasLength(1));
      expect(result.first.id, id);
      expect(result.first.title, title);
      expect(result.first.sortingOrder, sortingOrder);
      expect(result.first.tabsIds, tabsIds);
      expect(result.first.isEditable, isEditable);
    });

    test('init groups', () {
      final tabIds = ['0'];

      when(
        () => storageBox.write(
          BrowserGroupsStorageService.browserGroupsKey,
          any<List<dynamic>>(),
        ),
      ).thenAnswer((_) async {});

      final result = browserGroupsStorageService.initGroups(tabIds);

      verify(
        () => storageBox.write(
          BrowserGroupsStorageService.browserGroupsKey,
          any<List<Map<String, dynamic>>>(),
        ),
      ).called(1);

      expect(result, hasLength(1));
      expect(result.first.id, equals(tabsGroupId));
    });

    test('save groups', () {
      final group = BrowserGroup.fromJson({
        'id': '0',
        'title': 'Test title',
        'sortingOrder': 1.0,
        'tabsIds': ['0'],
        'isEditable': true,
      });

      when(
        () => storageBox.write(
          BrowserGroupsStorageService.browserGroupsKey,
          any<List<dynamic>>(),
        ),
      ).thenAnswer((_) async {});

      browserGroupsStorageService.saveGroups([group]);

      final captured =
          verify(
                () => storageBox.write(
                  BrowserGroupsStorageService.browserGroupsKey,
                  captureAny<List<dynamic>>(),
                ),
              ).captured.single
              as List<dynamic>;

      expect(captured, hasLength(1));
      expect(captured.first, equals(group.toJson()));
    });
  });
}
