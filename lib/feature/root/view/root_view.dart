import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class RootView extends StatefulWidget {
  const RootView({required this.child, super.key});

  final Widget child;

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  static final _logger = Logger('RootView');

  late final _appLinksService = inject<AppLinksService>();
  late final _navigationService = inject<NavigationService>();
  late final _tonConnectHttpBridge = inject<TonConnectHttpBridge>();
  late final _tonConnectService = inject<TonConnectService>();
  late final _messengerService = inject<MessengerService>();

  int get _tabIndex => RootTab.getByPath(
        getRootPath(fullPath: _navigationService.state.fullPath),
      ).index;

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;
  StreamSubscription<TonConnectAppLinksData>? _tonConnectLinkSubs;
  StreamSubscription<TonConnectUiEvent>? _uiEventsSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs =
          _appLinksService.browserLinksStream.listen(_listenAppLinks);
      _tonConnectLinkSubs =
          _appLinksService.tonConnecLinksData.listen(_onTonConnectAppLink);
    });

    _uiEventsSubscription =
        _tonConnectService.uiEventsStream.listen(_onUiEvent);
  }

  @override
  void dispose() {
    _appLinksNavSubs?.cancel();
    _tonConnectLinkSubs?.cancel();
    _uiEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
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
      bottomNavigationBar: AnimatedSlide(
        duration: defaultAnimationDuration,
        offset: Offset(0, isBottomNavigationBarVisible ? 0 : 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d48,
          ),
          decoration: BoxDecoration(
            color: theme.colors.background1,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensSizeV2.d16),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: SafeArea(
              child: SizedBox(
                height: DimensSizeV2.d48,
                child: ClipRect(
                  child: OverflowBox(
                    maxHeight: double.infinity,
                    alignment: Alignment.topCenter,
                    child: BottomNavigationBar(
                      landscapeLayout:
                          BottomNavigationBarLandscapeLayout.centered,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      elevation: DimensSizeV2.d0,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: theme.colors.background1,
                      selectedItemColor: theme.colors.content0,
                      unselectedItemColor: theme.colors.content3,
                      items: _getItems(),
                      currentIndex: _tabIndex,
                      onTap: _onTap,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getItems() =>
      RootTab.values.map((tab) => tab.item()).toList();

  void _onTap(int value) {
    _changeValue(RootTab.values[value]);
  }

  void _changeValue(RootTab tab) {
    final prevTab = RootTab.values[_tabIndex];

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

  void _onTonConnectAppLink(TonConnectAppLinksData data) {
    try {
      _tonConnectHttpBridge.connect(query: data.query);
    } catch (e, s) {
      _logger.warning('Failed to connect', e, s);
    }
  }

  void _onUiEvent(TonConnectUiEvent event) {
    event.when(
      error: (message) => _messengerService.show(
        Message.error(context: context, message: message),
      ),
      connect: (request, manifest, completer) async {
        final result = await showTCConnectSheet(
          context: context,
          request: request,
          manifest: manifest,
        );
        completer.complete(result);
      },
      sendTransaction: (connection, payload, completer) async {
        final result = await showTCSendMessageSheet(
          context: context,
          connection: connection,
          payload: payload,
        );
        completer.complete(result);
      },
      signData: (connection, payload, completer) async {
        final result = await showTCSignDataSheet(
          context: context,
          connection: connection,
          payload: payload,
        );
        completer.complete(result);
      },
    );
  }
}
