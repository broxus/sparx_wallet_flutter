import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

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

/// Data model for NewExternalAccount route
@freezed
class NewExternalAccountRouteData
    with _$NewExternalAccountRouteData
    implements CompassRouteData {
  const factory NewExternalAccountRouteData() =
      _NewExternalAccountRouteData;

  const NewExternalAccountRouteData._();
}
