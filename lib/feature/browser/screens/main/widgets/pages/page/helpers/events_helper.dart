import 'dart:async';

import 'package:app/app/service/permissions_service.dart';
import 'package:app/feature/browser/custom_web_controller.dart';
import 'package:app/utils/utils.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' as nwv;
import 'package:ui_components_lib/ui_components_lib.dart';

class EventsHelper {
  EventsHelper(this._nekotonRepository, this._permissionsService);

  final NekotonRepository _nekotonRepository;
  final PermissionsService _permissionsService;

  final _subs = <StreamSubscription<dynamic>>[];

  final _log = Logger('EventsHelper');

  void init({
    required String tabId,
    required CustomWebViewController controller,
  }) {
    _subs.addAll([
      _nekotonRepository
          .tabTransactionsStream(tabId)
          .listen(
            (event) => controller.transactionsFound(
              nwv.TransactionsFoundEvent(
                event.address.address,
                event.transactions
                    .map((e) => nwv.Transaction.fromJson(e.toJson()))
                    .toList(),
                nwv.TransactionsBatchInfo.fromJson(event.info.toJson()),
              ),
            ),
          ),
      _nekotonRepository
          .tabStateChangesStream(tabId)
          .listen(
            (state) => controller.contractStateChanged(
              nwv.ContractStateChangedEvent(
                state.address.address,
                nwv.ContractState.fromJson(state.state.toJson()),
              ),
            ),
          ),
      _nekotonRepository.currentTransportStream.listen(
        (transport) async => controller.networkChanged(
          nwv.NetworkChangedEvent(
            transport.transport.name,
            transport.transport.networkId,
          ),
        ),
      ),
      _nekotonRepository.hasSeeds.listen((hasSeeds) {
        if (!hasSeeds) controller.loggedOut();
      }),
      _permissionsService.permissionsStream
          // The stream emits the current cached permissions immediately on
          // subscription. That initial snapshot is already reflected in the
          // controller when the tab is created, so we skip it here and react
          // only to subsequent changes in permissions.
          .skip(1)
          .asyncMap((permissions) async {
            final url = await controller.getUrl();
            return url?.let((it) => permissions[Uri.parse(it.universalOrigin)]);
          })
          .distinct()
          .listen((permissions) async {
            try {
              await controller.permissionsChanged(
                nwv.PermissionsChangedEvent(
                  nwv.PermissionsPartial.fromJson(permissions?.toJson() ?? {}),
                ),
              );
            } catch (e, s) {
              _log.severe('ERROR', e, s);
            }
          }),
    ]);
  }

  void dispose() {
    for (final sub in _subs) {
      sub.cancel();
    }
  }
}
