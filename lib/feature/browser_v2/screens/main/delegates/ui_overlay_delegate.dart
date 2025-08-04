import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:flutter/cupertino.dart';

class BrowserOverlayUiDelegate {
  final _entries = <OverlayEntry>{};

  void init(
    BuildContext context, {
    required WidgetBuilder indicatorBuilder,
    required WidgetBuilder menuListBuilder,
    required WidgetBuilder menuPageBuilder,
    required WidgetBuilder menuHostBuilder,
    required WidgetBuilder pastGoBuilder,
  }) {
    _entries
      ..add(_createEntry(indicatorBuilder))
      ..add(_createEntry(menuListBuilder))
      ..add(_createEntry(menuPageBuilder))
      ..add(_createEntry(menuHostBuilder))
      ..add(
        _createEntry(
          pastGoBuilder,
          bottom: BrowserTabsListActionBar.height + 44,
        ),
      );
    for (final entry in _entries) {
      Overlay.of(context).insert(entry);
    }
  }

  void dispose() {
    for (final entry in _entries) {
      entry.remove();
    }

    _entries.clear();
  }

  OverlayEntry _createEntry(
    WidgetBuilder builder, {
    double bottom = 0,
  }) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          bottom: bottom,
          left: 0,
          right: 0,
          child: builder(context),
        );
      },
    );
  }
}
