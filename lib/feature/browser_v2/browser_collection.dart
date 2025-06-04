import 'dart:math';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/feature/browser_v2/data/broser_entity.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';

class BrowserCollection<T extends BrowserEntity> {
  final _map = <String, NotNullNotifier<T>>{};

  final _idsState = NotNullNotifier<List<String>>([]);

  final _activeEntityIdState = StateNotifier<String?>();

  List<T> get entities => _map.values.map((n) => n.value).toList();

  NotNullListenableState<List<String>> get idsState => _idsState;

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
      return;
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

    if (removedIndex == null) {
      return null;
    }

    _idsState
      ..value.removeAt(removedIndex)
      ..update();

    return removedIndex;
  }

  NotNullListenableState<T>? getListenable(String entityId) =>
      getNotifier(entityId);

  void updateTitle({
    required String id,
    required String title,
  }) {
    _map[id]
      ?..value.title = title
      ..update();
  }

  void setActiveById(String? id) => _activeEntityIdState.accept(id);

  void setActiveByIndex(int index) => _activeEntityIdState.accept(
        _idsState.value[min(
          index,
          _idsState.value.length - 1,
        )],
      );

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

  void clearTabs() {
    _map.forEach(
      (_, notifier) {
        if (notifier.value.tabsIds.isNotEmpty) {
          notifier
            ..value.tabsIds.clear()
            ..update();
        }
      },
    );
  }

  int? removeTabId({
    required String tabId,
    String? groupId,
  }) {
    NotNullNotifier<BrowserGroup>? groupNotifier;

    if (groupId == null) {
      final notifiers = _map.values;
      for (final notifier in notifiers) {
        if (notifier.value.tabsIds.contains(tabId)) {
          groupNotifier = notifier;
          break;
        }
      }
    } else {
      groupNotifier = getNotifier(groupId);
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
      _map.remove(id)?.dispose();
    }

    _idsState.accept(_map.keys.toList());
  }

  Uri? getCachedUrl(String tabId) => getNotifier(tabId)?.value.url;
}

extension on NotNullNotifier<dynamic> {
  NotNullNotifier<dynamic> update() {
    accept(value, isUnique: false);
    return this;
  }
}
