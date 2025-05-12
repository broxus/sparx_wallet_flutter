import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_account_page.dart';
import 'package:app/feature/wallet/new_account/add_external_account/route.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class AddAccountRoute extends CompassRouteParameterless<AddAccountRouteData> {
  AddAccountRoute(
    SelectSeedRoute selectSeedRoute,
    NewAccountRoute newAccountRoute,
    NewExternalAccountRoute newExternalAccountRoute,
  ) : super(
          name: 'wallet-add-account',
          builder: (context, _, __) => const AddAccountPage(),
          compassBaseRoutes: [
            selectSeedRoute,
            newAccountRoute,
            newExternalAccountRoute,
          ],
        );

  @override
  AddAccountRouteData dataFabric() {
    return const AddAccountRouteData();
  }
}

/// Data model for AddAccount route
@freezed
class AddAccountRouteData
    with _$AddAccountRouteData
    implements CompassRouteData {
  const factory AddAccountRouteData() = _AddAccountRouteData;

  const AddAccountRouteData._();
}
