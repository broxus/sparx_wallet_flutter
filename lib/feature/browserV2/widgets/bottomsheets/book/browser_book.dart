import 'package:app/feature/browserV2/widgets/bottomsheets/book/browser_book_wm.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/history/history_list.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/tab_bar.dart';
import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showBookModal(BuildContext context) {
  showPrimaryBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(.8),
    padding: EdgeInsets.zero,
    bottomSpaceSize: 0,
    content: const BrowserBook(),
  );
}

class BrowserBook extends ElementaryWidget<BrowserBookWidgetModel> {
  const BrowserBook({
    super.key,
    WidgetModelFactory<BrowserBookWidgetModel> wmFactory =
        defaultBrowserBookWidgetModelFactory,
  }) : super(wmFactory);

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BrowserBookWidgetModel wm) {
    return SizedBox(
      height: wm.height,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BrowserBookTabBar(
              tabBarState: wm.tabBarState,
              onPressedTab: wm.onPressedTab,
            ),
          ),
          //BrowserBookTabBar
          Positioned.fill(
            top: BrowserBookTabBar.height + DimensSizeV2.d16,
            child: StateNotifierBuilder(
              listenableState: wm.tabBarState,
              builder: (_, BrowserBookTabBarValue? value) {
                return Visibility(
                  visible: value == BrowserBookTabBarValue.bookMarks,
                  child: AnimatedOpacity(
                    opacity: value == BrowserBookTabBarValue.bookMarks ? 1 : 0,
                    duration: _duration,
                    child: const BookmarksList(),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            top: BrowserBookTabBar.height + DimensSizeV2.d16,
            child: StateNotifierBuilder(
              listenableState: wm.tabBarState,
              builder: (_, BrowserBookTabBarValue? value) {
                return Visibility(
                  visible: value == BrowserBookTabBarValue.history,
                  child: AnimatedOpacity(
                    opacity: value == BrowserBookTabBarValue.history ? 1 : 0,
                    duration: _duration,
                    child: const HistoryList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    // return SizedBox(
    //   height: wm.height,
    //   child: Column(
    //     children: [
    //       Flexible(
    //         child: BrowserBookTabBar(
    //           tabBarState: wm.tabBarState,
    //           onPressedTab: wm.onPressedTab,
    //         ),
    //       ),
    //       const SizedBox(height: DimensSizeV2.d16),
    //       Flexible(
    //         child: StateNotifierBuilder(
    //           listenableState: wm.tabBarState,
    //           builder: (_, BrowserBookTabBarValue? value) {
    //             return Visibility(
    //               visible: value == BrowserBookTabBarValue.bookMarks,
    //               child: AnimatedOpacity(
    //                 opacity: value == BrowserBookTabBarValue.bookMarks ? 1 : 0,
    //                 duration: _duration,
    //                 child: const BookmarksList(),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //       // Flexible(
    //       //   child: StateNotifierBuilder(
    //       //     listenableState: wm.tabBarState,
    //       //     builder: (_, BrowserBookTabBarValue? value) {
    //       //       return Visibility(
    //       //         visible: value == BrowserBookTabBarValue.history,
    //       //         child: AnimatedOpacity(
    //       //           opacity: value == BrowserBookTabBarValue.history ? 1 : 0,
    //       //           duration: _duration,
    //       //           child: Container(
    //       //             width: 100,
    //       //             height: 100,
    //       //             color: Colors.red,
    //       //           ),
    //       //         ),
    //       //       );
    //       //     },
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
