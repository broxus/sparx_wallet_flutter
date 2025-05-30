import 'dart:math';

import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/feature/browser_v2/data/broser_entity.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class BrowserCollection<T extends BrowserEntity> {
  final _map = <String, NotNullNotifier<T>>{};

  late final _idsState = NotNullNotifier<List<String>>(_map.keys.toList());

  late final _activeEntityIdState = StateNotifier<String?>();

  List<T> get entities => _map.values.map((n) => n.value).toList();

  ListenableState<List<String>> get idsState => _idsState;

  ListenableState<String?> get activeEntityIdState => _activeEntityIdState;

  int get count => _map.length;

  @mustCallSuper
  void dispose() {
    _map.forEach((_, notifier) {
      notifier.dispose();
    });
    _activeEntityIdState.dispose();
    _idsState.dispose();
  }

  void clear() {
    _map
      ..forEach((_, notifier) => notifier.dispose())
      ..clear();
    _activeEntityIdState.accept(null);
    _idsState.accept([]);
  }

  void addList(List<T> entities) {
    for (final entity in entities) {
      _map[entity.id] = NotNullNotifier(entity);
      _idsState.value.add(entity.id);
    }
    _idsState.update();
  }

  void add(T entity) {
    if (_map.containsKey(entity.id)) {
      _map[entity.id]?.accept(entity);
    }

    _map[entity.id] = NotNullNotifier(entity);
    _idsState
      ..value.add(entity.id)
      ..update();
  }

  int? remove(String entityId) {
    _map.remove(entityId)?.dispose();

    final ids = _idsState.value;
    final count = ids.length;

    int? removedIndex;

    for (var i = 0; i < count; i++) {
      if (ids[i] == entityId) {
        removedIndex = i;
        break;
      }
    }

    _idsState
      ..value.remove(entityId)
      ..update();

    return removedIndex;
  }

  ListenableState<T>? getListenable(String entityId) => getNotifier(entityId);

  void updateTitle({
    required String id,
    required String title,
  }) {
    _map[id]
      ?..value.title = title
      ..update();
  }

  void setActiveById(String? id) => _activeEntityIdState.accept(id);

  void setActiveByIndex(int index) => _idsState.value[min(
        index,
        _idsState.value.length - 1,
      )];

  bool checkExistEntity(String id) => _map[id] != null;

  @protected
  NotNullNotifier<T>? getNotifier(String entityId) => _map[entityId];
}

class GroupsCollection extends BrowserCollection<BrowserGroup> {
  void addTabId({
    required String groupId,
    required String tabId,
  }) {
    getNotifier(groupId)
      ?..value.tabsIds.add(tabId)
      ..update();
  }

  int? removeTabId({
    required String tabId,
    String? groupId,
  }) {
    if (groupId == null) {
      final notifiers = _map.values;
      for (final notifier in notifiers) {
        if (notifier.value.tabsIds.contains(tabId)) {
          groupId = notifier.value.id;
          break;
        }
      }
    }

    if (groupId == null) {
      return null;
    }

    final notifier = getNotifier(groupId);

    if (notifier == null) {
      return null;
    }

    final tabsIds = notifier.value.tabsIds;

    final index = tabsIds.indexWhere((id) => id == tabId);

    if (index == -1) {
      return null;
    }

    tabsIds.remove(tabId);

    notifier.update();

    return index;
  }

  List<String>? getTabIds(String groupId) =>
      getNotifier(groupId)?.value.tabsIds;

  int? getTabIndex({
    required String groupId,
    required String tabId,
  }) {
    final index = getTabIds(groupId)?.indexWhere((id) => id == tabId);

    return index == -1 ? null : index;
  }

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return getTabIds(groupId)?[index];
  }
}

class TabsCollection extends BrowserCollection<BrowserTab> {
  void updateUrl({
    required String tabId,
    required Uri uri,
  }) {
    getNotifier(tabId)
      ?..value.url = uri
      ..update();
  }

  void removeList(List<String> ids) {
    for (final id in ids) {
      remove(id);
    }
  }

  Uri? getCachedUrl(String tabId) => getNotifier(tabId)?.value.url;
}

extension on NotNullNotifier<dynamic> {
  NotNullNotifier<dynamic> update() {
    accept(value, isUnique: false);
    return this;
  }
}
