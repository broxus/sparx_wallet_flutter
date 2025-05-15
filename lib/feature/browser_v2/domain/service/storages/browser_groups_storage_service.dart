import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/utils/json/json_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserGroupsDomain = 'browser_groups';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserGroupsStorageService extends AbstractStorageService {
  BrowserGroupsStorageService(
    @Named(container) this._groupsStorage,
    @Named(BrowserTabsStorageService.container) this._tabsStorage,
  );

  static const container = _browserGroupsDomain;
  static const browserGroupsKey = 'browser_groups_key';

  final GetStorage _groupsStorage;
  final GetStorage _tabsStorage;

  @override
  Future<void> init() async {
    await GetStorage.init(container);
  }

  @override
  Future<void> clear() async {
    try {
      await _groupsStorage.erase();
    } catch (_) {}
  }

  List<BrowserGroup> initGroups() {
    var groups = _groupsStorage.read<List<dynamic>>(browserGroupsKey);

    if (groups == null || groups.isEmpty) {
      final tabs = castJsonList<Map<String, dynamic>>(
        _tabsStorage.getEntries()[BrowserTabsStorageService.browserTabsKey],
      );

      final tabsGroup = {
        'id': tabsGroupId,
        'title': LocaleKeys.tabs.tr(),
        'tabsIds': [
          for (final tabJson in tabs) tabJson['id'] as String,
        ],
        'sortingOrder': NtpTime.now().millisecondsSinceEpoch.toDouble(),
        'isCanRemoved': false,
        'isCanEditTitle': false,
      };

      groups = (groups ?? [])..add(tabsGroup);

      _groupsStorage.write(
        browserGroupsKey,
        groups,
      );
    }

    return _parseGroups(groups);
  }

  List<BrowserGroup> _parseGroups(List<dynamic> list) {
    return [
      for (final entry in list)
        BrowserGroup.fromJson(entry as Map<String, dynamic>),
    ];
  }

  void saveBrowserGroups(List<BrowserGroup> groups) {
    _groupsStorage.write(
      browserGroupsKey,
      groups.map((e) => e.toJson()).toList(),
    );
  }
}
