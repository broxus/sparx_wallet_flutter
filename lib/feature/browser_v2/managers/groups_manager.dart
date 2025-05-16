import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/groups/groups_data.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';

class BrowserGroupsManager {
  BrowserGroupsManager(
    this._browserGroupsStorageService,
  );

  final BrowserGroupsStorageService _browserGroupsStorageService;

  final _activeGroupState = StateNotifier<BrowserGroup?>();

  final _groupsState = StateNotifier<BrowserGroupsCollection>(
    initValue: BrowserGroupsCollection(),
  );

  ListenableState<BrowserGroup?> get activeGroupState => _activeGroupState;

  ListenableState<BrowserGroupsCollection> get groupsState => _groupsState;

  List<BrowserGroup> get _browserGroups => _groupsCollection.list;

  BrowserGroupsCollection get _groupsCollection =>
      _groupsState.value ?? BrowserGroupsCollection();

  BrowserGroup? get _activeTab => activeGroupState.value;

  String? get _activeTabId => _activeTab?.id;

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
    _groupsState.accept(BrowserGroupsCollection());
    _activeGroupState.accept(null);
  }

  String createBrowserGroup({
    String? title,
    List<String>? tabsIds,
  }) {
    final list = [..._browserGroups];

    final group = BrowserGroup.create(
      name: title ?? LocaleKeys.groupWithCount.tr(args: ['${list.length}']),
      tabsIds: tabsIds,
    );

    _setGroups(groups: list..add(group));

    return group.id;
  }

  void updateTitle(String tabId, String title) {
    final groups = [..._browserGroups];

    final index = _browserGroups.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return;
    }

    groups[index] = groups[index].copyWith(title: title);

    _setGroups(groups: groups);
  }

  Future<void> removeBrowserGroup(String id) async {
    final groups = [..._browserGroups]..removeWhere((group) => group.id == id);

    _setGroups(groups: groups);
  }

  void setActiveGroup(String? id) {
    if (id == _activeTabId) {
      return;
    }

    _setGroups(activeGroupId: id);
  }

  void _fetchGroupsFromCache() {
    final groups = _browserGroupsStorageService.getGroups()
      ..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    if (groups.isEmpty) {
      final createdGroup = _browserGroupsStorageService.initGroups();
      groups.add(createdGroup);
    }

    final savedId = _browserGroupsStorageService.getActiveGroupId();

    final activeGroup = savedId == null
        ? null
        : groups.firstWhereOrNull((tab) => tab.id == savedId);
print('!!! $activeGroup');
    _groupsState.accept(BrowserGroupsCollection(groups));
    _activeGroupState.accept(activeGroup ?? groups.firstOrNull);
  }

  void _setGroups({
    List<BrowserGroup>? groups,
    String? activeGroupId,
  }) {
    if (groups != null) {
      _browserGroupsStorageService.saveGroups(groups);
      _groupsState.accept(BrowserGroupsCollection(groups));
    }

    if (activeGroupId != null) {
      _browserGroupsStorageService.saveActiveGroupId(activeGroupId);
      _activeGroupState.accept(
        (groups ?? _browserGroups)
            .firstWhereOrNull((t) => t.id == activeGroupId),
      );
    }
  }
}
