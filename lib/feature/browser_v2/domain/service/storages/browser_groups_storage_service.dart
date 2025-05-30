import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserGroupsDomain = 'browser_groups';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserGroupsStorageService extends AbstractStorageService {
  BrowserGroupsStorageService(
    @Named(container) this._groupsStorage,
  );

  static const container = _browserGroupsDomain;
  static const browserGroupsKey = 'browser_groups_key';
  static const _browserGroupsActiveTabIdKey = 'browser_tabs_active_tab_id_key';

  final GetStorage _groupsStorage;

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

  List<BrowserGroup> getGroups() {
    final groups = _groupsStorage.read<List<dynamic>>(browserGroupsKey);

    if (groups == null) {
      return [];
    }

    return [
      for (final group in groups)
        BrowserGroup.fromJson(group as Map<String, dynamic>),
    ];
  }

  List<BrowserGroup> initGroups([List<String>? tabIds]) {
    final tabsGroup = <String, dynamic>{
      'id': tabsGroupId,
      'title': LocaleKeys.tabs.tr(),
      'tabsIds': tabIds ?? [],
      'sortingOrder': NtpTime.now().millisecondsSinceEpoch.toDouble(),
      'isEditable': false,
    };

    _groupsStorage
      ..write(
        browserGroupsKey,
        [tabsGroup],
      )
      ..write(
        _browserGroupsActiveTabIdKey,
        tabsGroupId,
      );

    return [BrowserGroup.fromJson(tabsGroup)];
  }

  String? getActiveGroupId() =>
      _groupsStorage.read(_browserGroupsActiveTabIdKey);

  void saveActiveGroupId(String? id) {
    _groupsStorage.write(_browserGroupsActiveTabIdKey, id);
  }

  void saveGroups(List<BrowserGroup> groups) {
    _groupsStorage.write(
      browserGroupsKey,
      groups.map((e) => e.toJson()).toList(),
    );
  }
}
