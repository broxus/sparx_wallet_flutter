import 'dart:async';

import 'package:app/app/service/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_dialog.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] for [WorkchainSelector]
@injectable
class WorkchainSelectorWidgetModel
    extends CustomWidgetModel<WorkchainSelector, WorkchainSelectorModel> {
  WorkchainSelectorWidgetModel(
    super.model,
  );

  late final _currentConnectionState =
      createNotifierFromStream(model.currentConnectionStream);

  late final _currentWorkchainState =
      createNotifierFromStream(model.currentWorkchainStream);

  ListenableState<Connection?> get currentConnectionState =>
      _currentConnectionState;

  ListenableState<ConnectionWorkchain?> get currentWorkchainState =>
      _currentWorkchainState;

  bool get isShowWorkchainSelector => model.isDevelopment;

  Future<void> onPressed() async {
    final id = await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return WorkchainSelectorDialog(
          currentConnectionListanable: currentConnectionState,
          currentWorkchainListanable: currentWorkchainState,
        );
      },
    );

    final currentConnectionId = currentConnectionState.value?.id;

    if (currentConnectionId == null || id == null) {
      return;
    }

    unawaited(
      model.saveCurrentConnectionId(
        connectionId: currentConnectionId,
        workchainId: id,
      ),
    );
  }
}
