import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class NewExternalAccountRoute
    extends CompassRouteParameterless<NewExternalAccountRouteData> {
  NewExternalAccountRoute()
      : super(
          path: '/wallet-new-external-account',
          builder: (context, _, __) => const AddExternalAccountWidget(),
        );

  @override
  NewExternalAccountRouteData createData() {
    return const NewExternalAccountRouteData();
  }
}

class NewExternalAccountRouteData implements CompassRouteData {
  const NewExternalAccountRouteData();
}
