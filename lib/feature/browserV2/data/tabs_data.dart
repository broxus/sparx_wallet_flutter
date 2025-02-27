import 'package:app/feature/browserV2/models/tab/browser_tab.dart';

class BrowserTabsCollection {
  BrowserTabsCollection([List<BrowserTab>? list]) : list = list ?? [];

  final List<BrowserTab> list;

  late final sortedList = [...list]..sort(
      (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
    );

  int get count => list.length;
}
