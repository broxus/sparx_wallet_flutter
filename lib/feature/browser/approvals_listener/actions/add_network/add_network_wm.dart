import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_widget.dart';
import 'package:app/feature/browser/utils.dart';
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
class AddNetworkWidgetModel
    extends
        CustomWidgetModelParametrized<
          AddNetworkWidget,
          AddNetworkModel,
          AddNetworkWmParams
        > {
  AddNetworkWidgetModel(super.model);

  late final _loadingState = createValueNotifier(false);
  late final _switchNetworkState = createWmParamsNotifier(
    (it) => it.switchNetwork,
  );

  late final _originState = createWmParamsNotifier((it) => it.origin);

  late final _networkState = createWmParamsNotifier((it) => it.network);

  ValueListenable<Uri> get originState => _originState;

  ValueListenable<AddNetwork> get networkState => _networkState;

  ValueListenable<bool> get loadingState => _loadingState;

  ValueListenable<bool> get switchNetworkState => _switchNetworkState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onConfirm() async {
    _loadingState.value = true;
    try {
      final connection = _networkState.value.getConnection();
      final network = await model.addConnection(connection);

      if (_switchNetworkState.value) {
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
      _loadingState.value = false;
    }
  }

  // ignore: use_setters_to_change_properties, avoid_positional_boolean_parameters
  void onSwitchChanged(bool value) => _switchNetworkState.value = value;
}
