import 'dart:math';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/feature/browser/data/broser_entity.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class BrowserEntityReactiveStore<T extends BrowserEntity> {
  final _notifiersMap = <String, NotNullNotifier<T>>{};

  final _entitiesIdsListState = NotNullNotifier<List<String>>([]);

  final _activeEntityIdState = StateNotifier<String?>();

  List<T> get entities => _notifiersMap.values.map((n) => n.value).toList();

  NotNullListenableState<List<String>> get entitiesIdsListState =>
      _entitiesIdsListState;

  ListenableState<String?> get activeEntityIdState => _activeEntityIdState;

  int get count => _notifiersMap.length;

  @mustCallSuper
  void dispose() {
    _notifiersMap.forEach((_, notifier) {
      notifier.dispose();
    });
    _activeEntityIdState.dispose();
    _entitiesIdsListState.dispose();
  }

  void clear() {
    _notifiersMap
      ..forEach((_, notifier) => notifier.dispose())
      ..clear();
    _activeEntityIdState.accept(null);
    _entitiesIdsListState.accept([]);
  }

  void addList(List<T> entities) {
    for (final entity in entities) {
      _notifiersMap[entity.id] = NotNullNotifier(entity);
      _entitiesIdsListState.value.add(entity.id);
    }

    _entitiesIdsListState.update();
  }

  void add(T entity) {
    if (_notifiersMap.containsKey(entity.id)) {
      _notifiersMap[entity.id]?.accept(entity);
      return;
    }

    _notifiersMap[entity.id] = NotNullNotifier(entity);
    _entitiesIdsListState
      ..value.add(entity.id)
      ..update();
  }

  int? remove(String entityId) {
    _notifiersMap.remove(entityId)?.dispose();

    final ids = _entitiesIdsListState.value;
    final count = ids.length;

    int? removedIndex;

    for (var i = 0; i < count; i++) {
      if (ids[i] == entityId) {
        removedIndex = i;
        break;
      }
    }

    if (removedIndex == null) {
      return null;
    }

    _entitiesIdsListState
      ..value.removeAt(removedIndex)
      ..update();

    return removedIndex;
  }

  NotNullListenableState<T>? getListenable(String entityId) =>
      getNotifier(entityId);

  void updateTitle({required String id, required String title}) {
    _notifiersMap[id]
      ?..value.title = title
      ..update();
  }

  void setActiveById(String? id) => _activeEntityIdState.accept(id);

  void setActiveByIndex(int index) => _activeEntityIdState.accept(
    _entitiesIdsListState.value[min(
      index,
      _entitiesIdsListState.value.length - 1,
    )],
  );

  bool checkExistEntity(String id) => _notifiersMap[id] != null;

  @protected
  NotNullNotifier<T>? getNotifier(String entityId) => _notifiersMap[entityId];
}

class GroupsReactiveStore extends BrowserEntityReactiveStore<BrowserGroup> {
  void addTabId({required String groupId, required String tabId}) {
    getNotifier(groupId)
      ?..value.tabsIds.add(tabId)
      ..update();
  }

  void clearTabs([String? groupId]) {
    if (groupId == null) {
      _notifiersMap.forEach((_, notifier) {
        if (notifier.value.tabsIds.isNotEmpty) {
          notifier
            ..value.tabsIds.clear()
            ..update();
        }
      });
      return;
    }

    _notifiersMap[groupId]
      ?..value.tabsIds.clear()
      ..update();
  }

  int? removeTabId({required String tabId, String? groupId}) {
    var groupNotifier = groupId == null ? null : getNotifier(groupId);

    if (groupNotifier == null) {
      final notifiers = _notifiersMap.values;
      for (final notifier in notifiers) {
        if (notifier.value.tabsIds.contains(tabId)) {
          groupNotifier = notifier;
          break;
        }
      }
    }

    if (groupNotifier == null) {
      return null;
    }

    final tabsIds = groupNotifier.value.tabsIds;

    final index = tabsIds.indexWhere((id) => id == tabId);

    if (index == -1) {
      return null;
    }

    tabsIds.removeAt(index);

    groupNotifier.update();

    return index;
  }

  List<String>? getTabIds(String groupId) =>
      getNotifier(groupId)?.value.tabsIds;

  int? getTabIndex({required String groupId, required String tabId}) {
    final index = getTabIds(groupId)?.indexWhere((id) => id == tabId);

    return index == -1 ? null : index;
  }

  String? getTabIdByIndex({required String groupId, required int index}) {
    final tabIds = getTabIds(groupId);

    return (tabIds == null || index >= tabIds.length) ? null : tabIds[index];
  }
}

class TabsReactiveStore extends BrowserEntityReactiveStore<BrowserTab> {
  void updateUrl({required String tabId, required Uri uri}) {
    getNotifier(tabId)
      ?..value.url = uri
      ..update();
  }

  void removeList(List<String> ids) {
    for (final id in ids) {
      _notifiersMap.remove(id)?.dispose();
    }

    _entitiesIdsListState.accept(_notifiersMap.keys.toList());
  }

  Uri? getCachedUrl(String tabId) => getNotifier(tabId)?.value.url;
}

extension on NotNullNotifier<dynamic> {
  NotNullNotifier<dynamic> update() {
    accept(value, isUnique: false);
    return this;
  }
}
