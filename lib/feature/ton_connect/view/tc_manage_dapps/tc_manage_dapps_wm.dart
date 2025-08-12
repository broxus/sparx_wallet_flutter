import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class TCManageDappsWidgetModel
    extends CustomWidgetModel<TCManageDappsWidget, TCManageDappsModel> {
  TCManageDappsWidgetModel(super.model);

  late final _connectionsState = createNotifierFromStream(model.connections);

  ListenableState<List<TonAppConnection>> get connectionsState => _connectionsState;

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
