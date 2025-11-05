import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/ui_models/ui_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_header.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_menu.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/book_search.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/bookmarks_empty.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/date_item.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/history_empty.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

void showBookModal(BuildContext context) {
  unawaited(
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withValues(alpha: .8),
      backgroundColor: Colors.transparent,
      elevation: 0,
      showDragHandle: false,
      builder: (_) {
        return const SafeArea(child: BrowserBook());
      },
    ),
  );
}

class BrowserBook extends InjectedElementaryWidget<BrowserBookWidgetModel> {
  const BrowserBook({super.key});

  @override
  Widget build(BrowserBookWidgetModel wm) {
    return Stack(
      children: [
        GestureDetector(onTap: wm.onBackgroundPressed),
        DraggableScrollableSheet(
          minChildSize: .3,
          maxChildSize: .8,
          snap: true,
          snapSizes: const [.6],
          builder: (_, ScrollController scrollController) {
            return PrimaryBottomSheetContainerBox(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  BookHeader(
                    tabBarState: wm.tabBarState,
                    onPressedTab: wm.onPressedTab,
                  ),
                  StateNotifierBuilder(
                    listenableState: wm.tabBarState,
                    builder: (_, BrowserBookTabBarValue? value) {
                      return switch (value) {
                        BrowserBookTabBarValue.bookMarks => BookSearch(
                          searchVisibleState:
                              wm.bookmarksDelegate.searchVisibleState,
                          searchController:
                              wm.bookmarksDelegate.searchController,
                        ),
                        BrowserBookTabBarValue.history => BookSearch(
                          searchVisibleState:
                              wm.historyDelegate.searchVisibleState,
                          searchController: wm.historyDelegate.searchController,
                        ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                  StateNotifierBuilder<List<BaseBookUiModel>>(
                    listenableState: wm.itemsState,
                    builder: (_, List<BaseBookUiModel>? list) {
                      if (list == null) {
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      } else if (list.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: DimensSizeV2.d40,
                            ),
                            child: switch (wm.tabBarState.value) {
                              BrowserBookTabBarValue.bookMarks =>
                                const BookmarksEmptyContent(),
                              BrowserBookTabBarValue.history =>
                                const HistoryEmptyEmptyContent(),
                              _ => const SizedBox.shrink(),
                            },
                          ),
                        );
                      }

                      return switch (wm.tabBarState.value) {
                        BrowserBookTabBarValue.bookMarks =>
                          SliverReorderableList(
                            proxyDecorator: _proxyDecorator,
                            itemCount: list.length,
                            onReorder: wm.bookmarksDelegate.onReorder,
                            itemBuilder: (_, int index) {
                              final item = list[index];

                              return switch (item) {
                                BookMarkUiModel() => BookmarkListItem(
                                  key: ValueKey(item.bookmarkId),
                                  index: index,
                                  editState: wm.bookmarksDelegate.editState,
                                  title: item.title,
                                  subTitle: item.subTitle,
                                  uri: item.uri,
                                  onPressed: () => wm.onPressedItem(item),
                                  onPressedRemove: () => wm.bookmarksDelegate
                                      .onPressedRemove(item.bookmarkId),
                                ),
                                _ => const SizedBox.shrink(),
                              };
                            },
                          ),
                        BrowserBookTabBarValue.history => SliverList.builder(
                          itemCount: list.length,
                          itemBuilder: (_, int index) {
                            final item = list[index];

                            return switch (item) {
                              DateUiModel(:final dateText) => DateItem(
                                key: ValueKey(dateText),
                                dateText: dateText,
                              ),
                              HistoryItemUiModel(
                                :final String id,
                                :final Uri uri,
                                :final String title,
                                :final String subTitle,
                              ) =>
                                HistoryListItem(
                                  key: ValueKey(id),
                                  editState: wm.historyDelegate.editState,
                                  uri: uri,
                                  title: title,
                                  subTitle: subTitle,
                                  onPressed: () => wm.onPressedItem(item),
                                  onPressedRemove: () =>
                                      wm.historyDelegate.onPressedRemove(id),
                                ),
                              _ => const SizedBox.shrink(),
                            };
                          },
                        ),
                        _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                      };
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: BrowserBookmarksMenu.height + 8),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: StateNotifierBuilder<BrowserBookTabBarValue>(
            listenableState: wm.tabBarState,
            builder: (_, BrowserBookTabBarValue? value) {
              return switch (value) {
                BrowserBookTabBarValue.bookMarks => BrowserBookmarksMenu(
                  editState: wm.bookmarksDelegate.editState,
                  activeState: wm.bookmarksDelegate.activeMenuState,
                  onPressedEdit: wm.bookmarksDelegate.onPressedEdit,
                  onPressedDone: wm.bookmarksDelegate.onPressedDone,
                ),
                BrowserBookTabBarValue.history => HistoryBookmarksMenu(
                  editState: wm.historyDelegate.editState,
                  activeEditState: wm.historyDelegate.activeEditState,
                  activeClearState: wm.historyDelegate.activeClearState,
                  onPressedEdit: wm.historyDelegate.onPressedEdit,
                  onPressedDone: wm.historyDelegate.onPressedDone,
                  onPressedClear: wm.onPressedClear,
                ),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ],
    );
  }

  Widget _proxyDecorator(Widget child, _, __) {
    return Material(color: Colors.transparent, child: child);
  }
}
