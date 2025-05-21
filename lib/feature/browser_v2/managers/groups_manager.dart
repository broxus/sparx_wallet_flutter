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

  final _allGroupsState = StateNotifier<BrowserGroupsCollection>(
    initValue: BrowserGroupsCollection(),
  );

  ListenableState<BrowserGroup?> get activeGroupState => _activeGroupState;

  ListenableState<BrowserGroupsCollection> get allGroupsState =>
      _allGroupsState;

  List<BrowserGroup> get allGroups => _allGroupsCollection.list;

  BrowserGroupsCollection get _allGroupsCollection =>
      _allGroupsState.value ?? BrowserGroupsCollection();

  BrowserGroup? get _activeGroup => activeGroupState.value;

  String? get _activeGroupId => _activeGroup?.id;

  void init() {
    _fetchGroupsFromCache();
  }

  void dispose() {
    _allGroupsState.dispose();
  }

  Future<void> clear() {
    return clearGroups();
  }

  Future<void> clearGroups() async {
    await _browserGroupsStorageService.clear();
    _allGroupsState.accept(BrowserGroupsCollection());
    _activeGroupState.accept(null);
  }

  BrowserGroup makeBrowserGroup({
    String? name,
    Set<String>? tabsIds,
  }) {
    final group = BrowserGroup.create(
      name: name ?? LocaleKeys.groupWithCount.tr(args: ['${allGroups.length}']),
      tabsIds: tabsIds,
    );

    return group;
  }

  String createBrowserGroup({
    String? name,
    Set<String>? tabsIds,
  }) {
    final list = [...allGroups];

    final group = makeBrowserGroup(
      name: name,
      tabsIds: tabsIds,
    );

    _setGroups(groups: list..add(group));

    return group.id;
  }

  void replaceGroups(List<BrowserGroup> groups) {
    _setGroups(groups: groups);
  }

  void updateTitle(String tabId, String title) {
    final groups = [...allGroups];

    final index = allGroups.indexWhere((t) => t.id == tabId);

    if (index == -1) {
      return;
    }

    groups[index] = groups[index].copyWith(title: title);

    _setGroups(groups: groups);
  }

  Future<void> removeBrowserGroup(String id) async {
    final groups = [...allGroups]..removeWhere((group) => group.id == id);

    _setGroups(groups: groups);
  }

  void setActiveGroup(String? id) {
    if (id == _activeGroupId) {
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

    _allGroupsState.accept(BrowserGroupsCollection(groups));
    _activeGroupState.accept(activeGroup ?? groups.firstOrNull);
  }

  void _setGroups({
    List<BrowserGroup>? groups,
    String? activeGroupId,
  }) {
    if (groups != null) {
      _browserGroupsStorageService.saveGroups(groups);
      _allGroupsState.accept(BrowserGroupsCollection(groups));
    }

    if (activeGroupId != null) {
      _browserGroupsStorageService.saveActiveGroupId(activeGroupId);
      _activeGroupState.accept(
        (groups ?? allGroups).firstWhereOrNull((t) => t.id == activeGroupId),
      );
    }
  }
}
