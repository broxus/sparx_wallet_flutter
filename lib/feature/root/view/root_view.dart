import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class RootView extends StatefulWidget {
  const RootView({required this.child, super.key});

  final Widget child;

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  static final _logger = Logger('RootView');

  late final _appLinksService = inject<AppLinksService>();
  late final _tonConnectHttpBridge = inject<TonConnectHttpBridge>();
  late final _tonConnectService = inject<TonConnectService>();
  late final _messengerService = inject<MessengerService>();

  StreamSubscription<TonConnectAppLinksData>? _tonConnectLinkSubs;
  StreamSubscription<TonConnectUiEvent>? _uiEventsSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tonConnectLinkSubs =
          _appLinksService.tonConnecLinksData.listen(_onTonConnectAppLink);
    });

    _uiEventsSubscription =
        _tonConnectService.uiEventsStream.listen(_onUiEvent);
  }

  @override
  void dispose() {
    _tonConnectLinkSubs?.cancel();
    _uiEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoutes = context.currentRoutes().toList();
    final lastRoute = currentRoutes.lastOrNull;

    final isBottomNavigationBarVisible =
        lastRoute?.isBottomNavigationBarVisible ?? false;
    final overrideExtend = lastRoute is WalletRoute;

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
        Message.error(message: message),
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
