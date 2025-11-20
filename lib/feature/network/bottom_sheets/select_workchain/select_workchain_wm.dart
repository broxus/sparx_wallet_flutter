import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/bottom_sheets/select_workchain/select_workchain_model.dart';
import 'package:app/feature/network/bottom_sheets/select_workchain/select_workchain_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectWorkchainWidgetModel
    extends CustomWidgetModel<SelectWorkchainWidget, SelectWorkchainModel> {
  SelectWorkchainWidgetModel(super.model);

  late final _currentConnectionState = createNotifierFromStream(
    model.currentConnectionStream,
  );

  late final _currentWorkchainState = createNotifierFromStream(
    model.currentWorkchainStream,
  );

  ListenableState<Connection?> get currentConnectionState =>
      _currentConnectionState;

  ListenableState<ConnectionWorkchain?> get currentWorkchainState =>
      _currentWorkchainState;

  void onItemTap(ConnectionWorkchain workchain) {
    model.saveCurrentConnectionId(
      connectionId: workchain.parentConnectionId,
      workchainId: workchain.id,
    );
    Navigator.of(context).pop();
  }
}
