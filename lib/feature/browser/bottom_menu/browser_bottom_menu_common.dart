// import 'package:app/app/router/router.dart';
// import 'package:app/di/di.dart';
// import 'package:app/feature/browser/browser.dart';
// import 'package:app/feature/browserV2/data/tabs_data.dart';
// import 'package:app/feature/browserV2/screens/main/data/control_panels_data.dart';
// import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
// import 'package:app/feature/browserV2/service/browser_service.dart';
// import 'package:app/generated/generated.dart';
// import 'package:elementary_helper/elementary_helper.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
// import 'package:ui_components_lib/ui_components_lib.dart';
//
// // TODO(knightforce): Elementary refactor
// class BrowserBottomMenuCommon extends StatefulWidget {
//   const BrowserBottomMenuCommon({super.key});
//
//   static const height = BrowserBottomBarPrimary.height;
//
//   @override
//   State<BrowserBottomMenuCommon> createState() =>
//       _BrowserBottomMenuCommonState();
// }
//
// class _BrowserBottomMenuCommonState extends State<BrowserBottomMenuCommon> {
//   late final _browserService = inject<BrowserService>();
//
//   @override
//   Widget build(BuildContext context) {
//     return DoubleSourceBuilder<BrowserTabsCollection, BrowserControlPanelData>(
//       firstSource: _browserService.tabs.tabsState,
//       secondSource: _browserService.tabs.controlPanelState,
//       builder: (
//         _,
//         BrowserTabsData? tabsData,
//         BrowserControlPanelData? panelData,
//       ) {
//         return BrowserBottomBarPrimary(
//           backSvg: Assets.images.navigateBack.path,
//           forwardSvg: Assets.images.navigateForward.path,
//           plusSvg: Assets.images.plusCircled.path,
//           historySvg: Assets.images.history.path,
//           dotsSvg: Assets.images.dots.path,
//           onCountIndicatorPressed: () => _onCountIndicatorPressed(context),
//           onBackPressed: panelData?.isCanGoBack ?? false
//               ? _browserService.tM.goBack
//               : null,
//           onForwardPressed: panelData?.isCanGoForward ?? false
//               ? _browserService.tM.goForward
//               : null,
//           onPlusPressed: () => _onPlusPressed(context),
//           onHistoryPressed: () => _onHistoryPressed(context),
//           onDotsPressed: () => _onDotsPressed(context),
//           tabCount: tabsData?.tabs.length ?? 0,
//         );
//       },
//     );
//   }
//
//   void _onCountIndicatorPressed(BuildContext context) {
//     context.goNamed(AppRoute.browserTabs.name);
//   }
//
//   void _onPlusPressed(BuildContext context) {
//     _browserService.tM.createEmptyTab();
//   }
//
//   void _onHistoryPressed(BuildContext context) {
//     context.goNamed(AppRoute.browserHistory.name);
//   }
//
//   void _onDotsPressed(BuildContext context) {
//     final currentTab = _browserService.tM.activeTab;
//
//     final canBeAddedToBookmarks =
//         inject<BrowserService>().bM.checkExistBookmarkByUri(currentTab?.url);
//
//     showBrowserPrimarySheet(
//       context: context,
//       refreshEnabled: currentTab?.isNotEmptyHost ?? false,
//       addToBookmarksEnabled: canBeAddedToBookmarks,
//       onRefreshPressed: _browserService.tM.refresh,
//       onAddToBookmarkPressed: _browserService.createCurrentTabBookMark,
//     );
//   }
// }
