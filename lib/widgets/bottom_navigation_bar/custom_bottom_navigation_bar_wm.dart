import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [CustomBottomNavigationBarWidgetModel]
CustomBottomNavigationBarWidgetModel
    defaultCustomBottomNavigationBarWidgetModelFactory(
  BuildContext context,
) {
  return CustomBottomNavigationBarWidgetModel(
    CustomBottomNavigationBarModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [CustomBottomNavigationBar]
class CustomBottomNavigationBarWidgetModel extends CustomWidgetModel<
    CustomBottomNavigationBar, CustomBottomNavigationBarModel> {
  CustomBottomNavigationBarWidgetModel(
    super.model,
  );

  late final _tabState = createNotifierFromStream<RootTab>(model.rootTabStream);
  late final _visibleState = createNotifier<bool>(true);

  StreamSubscription<OpenBrowserTabEvent>? _navigationOpenBrowserSub;

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  ListenableState<bool> get visibleState => _visibleState;

  ListenableState<RootTab> get tabState => _tabState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeData get themeData => Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );

  ThemeStyleV2 get _theme => context.themeStyleV2;

  late final List<BottomNavigationBarItem> items = [
    for (final tab in RootTab.values) tab.item(),
  ];

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _navigationOpenBrowserSub =
        primaryBus.on<OpenBrowserTabEvent>().listen(_onNavigationOpenBrowser);
    model.isBottomBarVisibleStream.listen(
      (isVisible) => _visibleState.accept(isVisible),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs = model.browserLinksStream.listen(_listenAppLinks);
    });
  }

  void _onNavigationOpenBrowser(OpenBrowserTabEvent event) {
    _changeValue(RootTab.browser);
  }

  @override
  void dispose() {
    _appLinksNavSubs?.cancel();
    _navigationOpenBrowserSub?.cancel();
    super.dispose();
  }

  void onTap(int value) {
    _changeValue(RootTab.values[value]);
  }

  void _changeValue(RootTab tab) {
    final prevTab = _tabState.value;

    final routeData = tab.routeData();
    context.compassPointNamed(routeData);

    primaryBus.fire(
      PressBottomNavigationEvent(
        prevTab: prevTab,
        currentTab: tab,
      ),
    );
  }

  void _listenAppLinks(BrowserAppLinksData data) {
    _changeValue(RootTab.browser);
  }
}
