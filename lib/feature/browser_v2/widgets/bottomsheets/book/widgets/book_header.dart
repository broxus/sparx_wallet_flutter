import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_bar.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet_container.dart';

class BookHeader extends StatelessWidget {
  const BookHeader({
    required this.tabBarState,
    required this.onPressedTab,
    super.key,
  });

  final ListenableState<BrowserBookTabBarValue> tabBarState;
  final ValueChanged<BrowserBookTabBarValue> onPressedTab;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _HeaderDelegate(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.themeStyleV2.colors.background1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(DimensRadiusV2.radius16),
              topRight: Radius.circular(DimensRadiusV2.radius16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PrimaryBottomSheetLabel(),
              BrowserBookTabBar(
                tabBarState: tabBarState,
                onPressedTab: onPressedTab,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({
    required this.child,
  });

  @override
  final double minExtent = 88;
  @override
  final double maxExtent = 88;
  final Widget child;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return SizedBox(
      height: maxExtent,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}