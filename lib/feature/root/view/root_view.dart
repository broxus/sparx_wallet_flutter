
import 'dart:async';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/di/di.dart';
import 'package:app/extensions/completer_extension.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
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
    return Scaffold(
      // We disable this isets, because this is a root Scaffold and we have
      // Scaffold -> Scaffold -> Content on a pages below, so if screen need
      // this insets, it can use
      resizeToAvoidBottomInset: false,
      body: widget.child,
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
        completer.completeSafe(
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
        completer.completeSafe(
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
        completer.completeSafe(
          await showTCSignDataSheet(
            // ignore: use_build_context_synchronously
            context: context,
            connection: connection,
            payload: payload,
          ),
        ),
    };
  }
}
