import 'package:app/app/router/compass/base.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class WalletSelectSeedRoute
    extends CompassRouteParameterless<WalletSelectSeedRouteData, void> {
  WalletSelectSeedRoute()
      : super(
          name: 'wallet-select-seed',
          builder: (context, _, __) => const SelectSeedPage(),
        );

  @override
  WalletSelectSeedRouteData dataFabric() {
    return const WalletSelectSeedRouteData();
  }
}

/// Data model for WalletSelectSeed route
@freezed
class WalletSelectSeedRouteData
    with _$WalletSelectSeedRouteData
    implements CompassRouteDataQuery {
  const factory WalletSelectSeedRouteData() = _WalletSelectSeedRouteData;

  const WalletSelectSeedRouteData._();

  @override
  Map<String, String> toQueryParams() {
    // This route doesn't require any parameters
    return {};
  }
}
