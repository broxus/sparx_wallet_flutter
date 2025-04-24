import 'dart:async';

import 'package:app/app/router/app_route.dart';
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
import 'package:go_router/go_router.dart';
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

  late final _tabState = createNotifier<RootTab>(model.currentNavTab);
  late final _visibleState = createNotifier<bool>(true);

  StreamSubscription<VisibleNavigationEvent>? _navigationVisibleSub;
  StreamSubscription<OpenBrowserTabEvent>? _navigationOpenBrowserSub;

  bool _isForceHide = false;

  GoRouterState get _routerState => GoRouterState.of(context);

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
    _updateVisible();
    _navigationVisibleSub =
        primaryBus.on<VisibleNavigationEvent>().listen(_onNavigationVisible);
    _navigationOpenBrowserSub =
        primaryBus.on<OpenBrowserTabEvent>().listen(_onNavigationOpenBrowser);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs = model.browserLinksStream.listen(_listenAppLinks);
    });
  }

  void _onNavigationVisible(VisibleNavigationEvent event) {
    _isForceHide = event is HideNavigationEvent;
    _updateVisible();
  }

  void _onNavigationOpenBrowser(OpenBrowserTabEvent event) {
    _changeValue(RootTab.browser);
  }

  @override
  void didChangeDependencies() {
    _updateVisible();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _appLinksNavSubs?.cancel();
    _navigationVisibleSub?.cancel();
    _navigationOpenBrowserSub?.cancel();
    super.dispose();
  }

  void onTap(int value) {
    _changeValue(RootTab.values[value]);
  }

  void _changeValue(RootTab tab) {
    final prevTab = model.currentNavTab;

    _tabState.accept(tab);

    context.goNamed(tab.name);

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

  void _updateVisible() {
    if (_isForceHide) {
      _visibleState.accept(false);
      return;
    }


    // The delay allows the route to be determined correctly.
    // Without Future, the route variable will contain the route from which
    // you left, not the route you went to.
    // A 50ms delay gives more guarantees.
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        final route = getCurrentAppRoute(fullPath: _routerState.fullPath);
        final isBottomNavigationBarVisible = route.isBottomNavigationBarVisible;
        _visibleState.accept(isBottomNavigationBarVisible);
      },
    );
  }
}
