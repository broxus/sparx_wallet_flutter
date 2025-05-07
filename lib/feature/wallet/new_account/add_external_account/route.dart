import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class WalletNewExternalAccountRoute
    extends CompassRouteParameterless<WalletNewExternalAccountRouteData> {
  WalletNewExternalAccountRoute()
      : super(
          name: 'wallet-new-external-account',
          builder: (context, _, __) => const AddExternalAccountPage(),
        );

  @override
  WalletNewExternalAccountRouteData dataFabric() {
    return const WalletNewExternalAccountRouteData();
  }
}

/// Data model for WalletNewExternalAccount route
@freezed
class WalletNewExternalAccountRouteData
    with _$WalletNewExternalAccountRouteData
    implements CompassRouteData {
  const factory WalletNewExternalAccountRouteData() =
      _WalletNewExternalAccountRouteData;

  const WalletNewExternalAccountRouteData._();
}
