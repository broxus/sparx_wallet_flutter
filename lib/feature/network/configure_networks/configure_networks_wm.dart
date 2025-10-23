import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/configure_networks/configure_networks_model.dart';
import 'package:app/feature/network/configure_networks/configure_networks_widget.dart';
import 'package:app/feature/network/edit_network/route.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class ConfigureNetworksWidgetModel
    extends CustomWidgetModel<ConfigureNetworksWidget, ConfigureNetworksModel> {
  ConfigureNetworksWidgetModel(super.model);

  late final _connectionsState = createNotifierFromStream(model.connections);

  ListenableState<List<Connection>> get connectionsState => _connectionsState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onItemTap(Connection connection) {
    context.compassContinue(
      EditNetworkRouteData(connectionDataId: connection.id)
    );
  }

  void onAddNetwork() {
    context.compassContinue(const EditNetworkRouteData());
  }
}
