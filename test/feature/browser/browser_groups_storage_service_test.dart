import 'package:app/app/service/ntp_service.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

class MockNtpService extends Mock implements NtpService {}

void main() {
  late BrowserGroupsStorageService browserGroupsStorageService;
  late MockGetStorage storage;
  late MockNtpService ntpService;

  final getIt = GetIt.instance;

  final now = DateTime.now();

  setUp(() async {
    await getIt.reset();
    ntpService = MockNtpService();
    storage = MockGetStorage();

    getIt.registerSingleton<NtpService>(ntpService);

    browserGroupsStorageService = BrowserGroupsStorageService(storage);

    when(() => ntpService.now()).thenReturn(now);
  });

  group('groups', () {
    test('get empty groups', () {
      when(
        () => storage.read<List<dynamic>>(
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
        () => storage.read<List<dynamic>>(
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
        () => storage.write(
          BrowserGroupsStorageService.browserGroupsKey,
          any<List<dynamic>>(),
        ),
      ).thenAnswer((_) async {});

      final result = browserGroupsStorageService.initGroups(tabIds);

      verify(
        () => storage.write(
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
        () => storage.write(
          BrowserGroupsStorageService.browserGroupsKey,
          any<List<dynamic>>(),
        ),
      ).thenAnswer((_) async {});

      browserGroupsStorageService.saveGroups([group]);

      final captured =
          verify(
                () => storage.write(
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
