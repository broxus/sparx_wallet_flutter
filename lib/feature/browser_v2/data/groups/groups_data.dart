import 'package:app/feature/browser_v2/data/groups/browser_group.dart';

extension BrowserGroupsCollectionExtension on List<BrowserGroup> {
  String get countText => length.toString();

  BrowserGroup? get lastGroup => lastOrNull;

  int getIndexById(String id) => indexWhere((item) => item.id == id);

  String? getIdByIndex(int index) {
    try {
      return this[index].id;
    } catch (_) {
      return null;
    }
  }
}

class ActiveGroupData {
  ActiveGroupData({
    required this.group,
    this.activeTabId,
  });

  final BrowserGroup group;
  final String? activeTabId;
  late final groupId = group.id;

  ActiveGroupData copyWith({
    BrowserGroup? group,
    String? activeTabId,
  }) {
    return ActiveGroupData(
      group: group ?? this.group,
      activeTabId: activeTabId ?? this.activeTabId,
    );
  }
}
