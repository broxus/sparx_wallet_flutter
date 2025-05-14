import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/utils/json/json.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV5 implements StorageMigration {
  StorageMigrationV5();

  static const int version = 5;

  @override
  Future<void> apply() async {
    await GetStorage.init(BrowserGroupsStorageService.container);
    await GetStorage.init(BrowserTabsStorageService.container);

    final groupsContainer = GetStorage(BrowserGroupsStorageService.container);
    final tabsContainer = GetStorage(BrowserTabsStorageService.container);

    final mainGroup = groupsContainer.getEntries()[mainTabsGroupId];
    final tabs = castJsonList<Map<String, dynamic>>(
      tabsContainer.getEntries()[BrowserTabsStorageService.browserTabsKey],
    );

    if (mainGroup != null) {
      return;
    }

    final result = <String, List<String>>{
      mainTabsGroupId: [
        for (final tabJson in tabs) tabJson['id'] as String,
      ],
    };

    await groupsContainer.write(mainTabsGroupId, result);
  }

  @override
  Future<void> complete() async {}
}
