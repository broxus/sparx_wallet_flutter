import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootView extends StatefulWidget {
  const RootView({required this.child, super.key});

  final Widget child;

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    final route =
        getCurrentAppRoute(fullPath: GoRouterState.of(context).fullPath);
    final isBottomNavigationBarVisible = route.isBottomNavigationBarVisible;
    final overrideExtend = route.overrideExtendScaffoldBody;

    return Scaffold(
      // We disable this isets, because this is a root Scaffold and we have
      // Scaffold -> Scaffold -> Content on a pages below, so if screen need
      // this insets, it can use resizeToAvoidBottomInset: true,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) {
          return MediaQuery(
            // we need to directly remove bottom padding if bottom bar is not
            // visible, because scaffold do not remove this padding if BottomBar
            // exists in the tree (but we do not remove it, just hide).
            data: MediaQuery.of(context).removePadding(
              removeBottom: !isBottomNavigationBarVisible,
            ),
            child: widget.child,
          );
        },
      ),
      extendBody: !isBottomNavigationBarVisible || overrideExtend,
      // IF WE HAVE PROBLEM with deleting MQ above, we need to replace Slide
      // widget to some ExpandablePanel, may be it will help.
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
