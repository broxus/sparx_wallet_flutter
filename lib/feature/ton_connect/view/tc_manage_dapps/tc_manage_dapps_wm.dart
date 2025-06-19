import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

TCManageDappsWidgetModel defaultTCManageDappsWidgetModelFactory(
  BuildContext context,
) =>
    TCManageDappsWidgetModel(
      TCManageDappsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TCManageDappsWidgetModel
    extends CustomWidgetModel<TCManageDappsWidget, TCManageDappsModel> {
  TCManageDappsWidgetModel(super.model);

  late final _connections = createNotifierFromStream(model.connections);

  ListenableState<List<TonAppConnection>> get connections => _connections;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onDisconnectAll() async {
    final confirmed = await showDappDisconnectConfirmationSheet(
      context: context,
    );

    if (confirmed ?? false) {
      model.disconnectAll();
    }
  }

  Future<void> onDisconnect(TonAppConnection connection) async {
    final confirmed = await showDappDisconnectConfirmationSheet(
      context: context,
      connection: connection,
    );

    if (confirmed ?? false) {
      model.disconnect(connection);
    }
  }
}
