import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/app/service/ton_connect/models/ton_connect_ui_event.dart';
import 'package:app/app/service/ton_connect/ton_connect_http_bridge.dart';
import 'package:app/app/service/ton_connect/ton_connect_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
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
  late final _ledgerService = inject<LedgerService>();

  StreamSubscription<TonConnectAppLinksData>? _tonConnectLinkSubs;
  StreamSubscription<TonConnectUiEvent>? _uiEventsSubscription;
  StreamSubscription<LedgerInteraction>? _ledgerInteractionSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tonConnectLinkSubs =
          _appLinksService.tonConnecLinksData.listen(_onTonConnectAppLink);
    });

    _uiEventsSubscription =
        _tonConnectService.uiEventsStream.listen(_onUiEvent);

    _ledgerInteractionSubscription =
        _ledgerService.interactionStream.listen(_onLedgerInteraction);
  }

  @override
  void dispose() {
    _tonConnectLinkSubs?.cancel();
    _uiEventsSubscription?.cancel();
    _ledgerInteractionSubscription?.cancel();
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

  Future<void> _onUiEvent(TonConnectUiEvent event) async {
    return switch (event) {
      TonConnectUiEventError(:final message) => _messengerService.show(
          Message.error(message: message),
        ),
      TonConnectUiEventConnect(
        :final request,
        :final manifest,
        :final completer,
      ) =>
        completer.complete(
          await showTCConnectSheet(
            context: context,
            request: request,
            manifest: manifest,
          ),
        ),
      TonConnectUiEventSendTransaction(
        :final connection,
        :final payload,
        :final completer,
      ) =>
        completer.complete(
          await showTCSendMessageSheet(
            // ignore: use_build_context_synchronously
            context: context,
            connection: connection,
            payload: payload,
          ),
        ),
      TonConnectUiEventSignData(
        :final connection,
        :final payload,
        :final completer,
      ) =>
        completer.complete(
          await showTCSignDataSheet(
            // ignore: use_build_context_synchronously
            context: context,
            connection: connection,
            payload: payload,
          ),
        ),
    };
  }

  Future<void> _onLedgerInteraction(LedgerInteraction interaction) async {
    try {
      await showLedgerInteractionSheet(
        context: context,
        interactionType: interaction.interactionType,
        stateStream: interaction.stateStream,
      );
    } finally {
      // dispose in case of cancelation by user
      await interaction.dispose();
    }
  }
}
