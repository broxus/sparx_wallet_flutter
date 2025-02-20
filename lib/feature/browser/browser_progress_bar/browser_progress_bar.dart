// import 'package:app/di/di.dart';
// import 'package:app/feature/browserV2/data/tabs_data.dart';
// import 'package:app/feature/browserV2/service/browser_service.dart';
// import 'package:elementary_helper/elementary_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:ui_components_lib/ui_components_lib.dart';
//
// // TODO(knightforce): check actual and Elementary refactor
// class BrowserProgressBar extends StatefulWidget {
//   const BrowserProgressBar({super.key});
//
//   @override
//   State<BrowserProgressBar> createState() => _BrowserProgressBarState();
// }
//
// class _BrowserProgressBarState extends State<BrowserProgressBar> {
//   late final _browserService = inject<BrowserService>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     StateNotifierBuilder(
//       listenableState: _browserService.tM.tabsState,
//       builder: (_, BrowserTabsData? data) {
//         final value = switch (currentTabState?.state) {
//           BrowserTabStateType.loading => (currentTabState?.progress ?? 0.0) / 100.0,
//           _ => null,
//         };
//       }
//     );
//
//
//
//     return value != null
//         ? ProgressBar(
//             value: value,
//             color: context.themeStyleV2.colors.accent,
//             height: DimensSizeV2.d3,
//           )
//         : const SizedBox();
//
//   }
// }
