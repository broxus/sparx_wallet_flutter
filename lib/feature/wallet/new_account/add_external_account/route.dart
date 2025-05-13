import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account_page.dart';
import 'package:injectable/injectable.dart';

@singleton
class NewExternalAccountRoute
    extends CompassRouteParameterless<NewExternalAccountRouteData> {
  NewExternalAccountRoute()
      : super(
          name: 'wallet-new-external-account',
          builder: (context, _, __) => const AddExternalAccountPage(),
        );

  @override
  NewExternalAccountRouteData dataFabric() {
    return const NewExternalAccountRouteData();
  }
}

class NewExternalAccountRouteData implements CompassRouteData {
  const NewExternalAccountRouteData();
}
