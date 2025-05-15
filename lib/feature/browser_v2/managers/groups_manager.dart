import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/groups/groups_data.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';

class BrowserGroupsManager {
  BrowserGroupsManager(
    this._browserGroupsStorageService,
  );

  final BrowserGroupsStorageService _browserGroupsStorageService;

  final _groupsState = StateNotifier<BrowserGroupsCollection>(
    initValue: BrowserGroupsCollection(),
  );

  List<BrowserGroup> get browserGroups => _groupsCollection.list;

  BrowserGroupsCollection get _groupsCollection =>
      _groupsState.value ?? BrowserGroupsCollection();

  void init() {
    _fetchGroupsFromCache();
  }

  void dispose() {
    _groupsState.dispose();
  }

  Future<void> clear() {
    return clearGroups();
  }

  Future<void> clearGroups() async {
    await _browserGroupsStorageService.clear();
  }

  String createBrowserGroup({
    String? title,
    List<String>? tabsIds,
  }) {
    final list = [...browserGroups];

    final group = BrowserGroup.create(
      name: title ?? LocaleKeys.groupWithCount.tr(args: ['${list.length}']),
      tabsIds: tabsIds,
    );

    _setGroups(list..add(group));

    return group.id;
  }

  void updateTitle(String tabId, String title) {
    final groups = [...browserGroups];

    final index = browserGroups.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return;
    }

    groups[index] = groups[index].copyWith(title: title);

    _setGroups(groups);
  }

  Future<void> removeBrowserGroup(String id) async {
    final groups = [...browserGroups]..removeWhere((group) => group.id == id);

    _setGroups(groups);
  }

  void _fetchGroupsFromCache() {
    final groups = _browserGroupsStorageService.initGroups()
      ..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    _groupsState.accept(BrowserGroupsCollection(groups));
  }

  void _setGroups(List<BrowserGroup> groups) {
    _browserGroupsStorageService.saveBrowserGroups(groups);
    _groupsState.accept(BrowserGroupsCollection(groups));
  }
}
