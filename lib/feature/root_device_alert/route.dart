import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class RootDeviceAlertRoute
    extends CompassRouteParameterless<RootDeviceAlertRouteData>
    implements IndependentSeedRoute {
  RootDeviceAlertRoute()
    : super(
        name: 'root-device-alert',
        path: '/root-device-alert',
        isSaveLocation: false,
        bottomBarState: BottomBarState.expanded,
        isTopLevel: true,
        builder: (context, data, _) => const RootDeviceAlertScreen(),
      );

  @override
  RootDeviceAlertRouteData createData() {
    return const RootDeviceAlertRouteData();
  }
}

class RootDeviceAlertRouteData implements CompassRouteData {
  const RootDeviceAlertRouteData();
}
