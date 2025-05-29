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
