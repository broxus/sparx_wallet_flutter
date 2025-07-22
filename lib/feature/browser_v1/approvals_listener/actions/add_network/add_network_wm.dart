import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/add_network/add_network_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/add_network/add_network_widget.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddNetworkWmParams {
  const AddNetworkWmParams({
    required this.origin,
    required this.network,
    required this.switchNetwork,
  });

  final Uri origin;
  final AddNetwork network;
  final bool switchNetwork;
}

@injectable
class AddNetworkWidgetModel extends InjectedWidgetModel<AddNetworkWidget,
    AddNetworkModel, AddNetworkWmParams> {
  AddNetworkWidgetModel(
    super.model,
  );

  late final _loading = createValueNotifier(false);
  late final _switchNetwork = createWmParamsNotifier(
    (it) => it.switchNetwork,
  );

  late final _origin = createWmParamsNotifier(
    (it) => it.origin,
  );

  late final _network = createWmParamsNotifier(
    (it) => it.network,
  );

  ValueListenable<Uri> get origin => _origin;

  ValueListenable<AddNetwork> get network => _network;

  ValueListenable<bool> get loading => _loading;

  ValueListenable<bool> get switchNetwork => _switchNetwork;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onConfirm() async {
    _loading.value = true;
    try {
      final connection = _network.value.getConnection();
      final network = await model.addConnection(connection);

      if (_switchNetwork.value) {
        await model.changeNetwork(connection.id);
      }

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop(network);
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
      _loading.value = false;
    }
  }

  // ignore: use_setters_to_change_properties, avoid_positional_boolean_parameters
  void onSwitchChanged(bool value) => _switchNetwork.value = value;
}
