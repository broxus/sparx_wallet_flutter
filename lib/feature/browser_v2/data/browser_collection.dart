import 'package:app/feature/browser_v2/data/browser_item.dart';

class BrowserCollection<T extends BrowserItem> {
  BrowserCollection([List<T>? list]) : list = list ?? [];

  final List<T> list;

  int get count => list.length;

  bool get isEmpty => list.isEmpty;

  bool get isNotEmpty => list.isNotEmpty;

  String get countText => count.toString();
}
