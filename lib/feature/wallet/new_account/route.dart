import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/add_account_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class WalletAddAccountRoute
    extends CompassRouteParameterless<WalletAddAccountRouteData> {
  WalletAddAccountRoute()
      : super(
          name: 'wallet-add-account',
          builder: (context, _, __) => const AddAccountPage(),
        );

  @override
  WalletAddAccountRouteData dataFabric() {
    return const WalletAddAccountRouteData();
  }
}

/// Data model for WalletAddAccount route
@freezed
class WalletAddAccountRouteData
    with _$WalletAddAccountRouteData
    implements CompassRouteData {
  const factory WalletAddAccountRouteData() = _WalletAddAccountRouteData;

  const WalletAddAccountRouteData._();
}
