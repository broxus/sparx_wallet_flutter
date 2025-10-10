import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/bottom_sheets/select_network/select_network_model.dart';
import 'package:app/feature/network/bottom_sheets/select_network/select_network_widget.dart';
import 'package:app/feature/network/configure_networks/route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectNetworkWidgetModel
    extends
        CustomWidgetModelParametrized<
          SelectNetworkWidget,
          SelectNetworkModel,
          bool
        > {
  SelectNetworkWidgetModel(super.model);

  late final _currentConnectionIdState = createNotifierFromStream(
    model.currentConnectionId,
  );
  late final _connectionsState = createNotifierFromStream(model.connections);

  ListenableState<String> get currentConnectionIdState =>
      _currentConnectionIdState;

  ListenableState<List<ConnectionData>> get connectionsState =>
      _connectionsState;

  bool get _needPopAfterAction => wmParams.value;

  void onConfigure() {
    if (_needPopAfterAction) Navigator.of(context).pop();
    context.compassContinue(const ConfigureNetworksRouteData());
  }

  void onItemTap(ConnectionData data) {
    if (_needPopAfterAction) Navigator.of(context).pop();
    model.changeCurrentConnection(data.id);
  }
}
