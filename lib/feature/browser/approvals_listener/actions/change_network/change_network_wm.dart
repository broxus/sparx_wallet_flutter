import 'dart:async';

import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ChangeNetworkWmParams {
  const ChangeNetworkWmParams({
    required this.origin,
    required this.networkId,
    required this.connections,
  });

  final Uri origin;
  final int networkId;
  final List<Connection> connections;
}

@injectable
class ChangeNetworkWidgetModel
    extends
        CustomWidgetModelParametrized<
          ChangeNetworkWidget,
          ChangeNetworkModel,
          ChangeNetworkWmParams
        > {
  ChangeNetworkWidgetModel(super.model);

  late final _originState = createWmParamsNotifier((it) => it.origin);

  late final _networkIdState = createWmParamsNotifier((it) => it.networkId);

  late final _connectionsState = createWmParamsNotifier((it) => it.connections);

  late final _connectionState = createWmParamsNotifier(
    (it) => it.connections.first,
  );

  ValueListenable<Uri> get originState => _originState;

  ValueListenable<int> get networkIdState => _networkIdState;

  ValueListenable<List<Connection>> get connectionsState => _connectionsState;

  late final _loadingState = createValueNotifier(false);

  ValueListenable<bool> get loadingState => _loadingState;

  ValueListenable<Connection> get connectionState => _connectionState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onConfirm() async {
    _loadingState.value = true;
    try {
      final strategy = await model.changeConnection(_connectionState.value.id);

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop(strategy);
      }
    } on TimeoutException catch (_) {
      if (contextSafe != null) {
        model.showError(contextSafe!, LocaleKeys.operationTimeout.tr());
      }
    } catch (e) {
      if (contextSafe != null) {
        model.showError(contextSafe!, e.toString());
      }
    } finally {
      _loadingState.value = false;
    }
  }

  // ignore: use_setters_to_change_properties
  void onConnectionChanged(Connection value) => _connectionState.value = value;
}
