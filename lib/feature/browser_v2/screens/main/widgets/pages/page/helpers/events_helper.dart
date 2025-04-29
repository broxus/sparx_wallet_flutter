import 'dart:async';

import 'package:app/app/service/js_servcie.dart';
import 'package:app/app/service/permissions_service.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' as nwv;

class EventsHelper {
  EventsHelper(
    this._nekotonRepository,
    this._permissionsService,
    this._jsService,
    this._tabId,
  ) {
    _jsService.loadNekotonJs();
  }

  final NekotonRepository _nekotonRepository;
  final PermissionsService _permissionsService;
  final JsService _jsService;
  final String _tabId;

  final _subs = <StreamSubscription<dynamic>>[];

  EntityValueListenable<String?> get nekotonJsState =>
      _jsService.nekotonJsState;

  void init(CustomWebViewController controller) {
    _subs.addAll([
      _nekotonRepository.tabTransactionsStream(_tabId).listen(
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
      _nekotonRepository.tabStateChangesStream(_tabId).listen(
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
      _permissionsService.permissionsStream.listen(
        (permissions) async {
          final url = await controller.getUrl();
          final currentPermissions =
              url == null ? null : permissions[Uri.parse(url.origin)];

          await controller.permissionsChanged(
            nwv.PermissionsChangedEvent(
              nwv.PermissionsPartial.fromJson(
                currentPermissions?.toJson() ?? {},
              ),
            ),
          );
        },
      ),
    ]);
  }

  void dispose() {
    for (final sub in _subs) {
      sub.cancel();
    }
  }
}
