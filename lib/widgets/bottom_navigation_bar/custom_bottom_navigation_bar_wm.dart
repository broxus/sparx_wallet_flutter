import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
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
  late final _visibleState = createNotifierFromStream<bool>(
    model.isBottomBarVisibleStream,
  );

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

  void onTap(int value) {
    final tab = RootTab.values[value];
    final isTabUpdated = model.tryToChangeTabAndCheckDiff(tab);

    if (isTabUpdated) {
      final routeData = tab.routeData();
      context.compassPointNamed(routeData);
    }
  }
}
