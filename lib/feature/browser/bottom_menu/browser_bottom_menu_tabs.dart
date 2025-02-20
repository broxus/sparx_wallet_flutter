import 'package:app/app/router/app_route.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// TODO(knightforce): Elementary refactor
class BrowserBottomMenuTabs extends StatefulWidget {
  const BrowserBottomMenuTabs({super.key});

  @override
  State<BrowserBottomMenuTabs> createState() => _BrowserBottomMenuTabsState();
}

class _BrowserBottomMenuTabsState extends State<BrowserBottomMenuTabs> {
  late final _browserService = inject<BrowserService>();

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<BrowserTabsData>(
      listenableState: _browserService.tM.tabsState,
      builder: (_, BrowserTabsData? data) {
        return BrowserBottomBarTabs(
          closeAllText: LocaleKeys.browserCloseAll.tr(),
          plusSvg: Assets.images.plusCircled.path,
          doneText: LocaleKeys.browserDone.tr(),
          onCloseAllPressed:
              data?.tabs.isEmpty ?? true ? null : _onCloseAllPressed,
          onPlusPressed: () => _onPlusPressed(context),
          onDonePressed: () => _onDonePressed(context),
        );
      },
    );
  }

  void _onCloseAllPressed() {
    _browserService.tM.clearTabs();
    context.goNamed(AppRoute.browser.name);
  }

  void _onPlusPressed(BuildContext context) {
    _browserService.tM.createEmptyTab();

    // TODO(knightforce): need it?
    context.goNamed(AppRoute.browser.name);
  }

  void _onDonePressed(BuildContext context) {
    context.goNamed(AppRoute.browser.name);
  }
}
