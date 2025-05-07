import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/add_existing_wallet/view/add_existing_wallet_page.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class AddExistingWalletRoute
    extends CompassRouteParameterless<AddExistingWalletRouteData> {
  AddExistingWalletRoute({
    required this.importWalletRoute,
  }) : super(
          name: 'add-existing-wallet',
          path: 'add-existing-wallet',
          builder: (context, _, __) => const AddExistingWalletPage(),
          compassBaseRoutes: [importWalletRoute],
        );

  final ImportWalletRoute importWalletRoute;

  @override
  AddExistingWalletRouteData dataFabric() {
    return const AddExistingWalletRouteData();
  }
}

/// Data model for AddExistingWallet route
@freezed
class AddExistingWalletRouteData
    with _$AddExistingWalletRouteData
    implements CompassRouteData {
  const factory AddExistingWalletRouteData() = _AddExistingWalletRouteData;

  const AddExistingWalletRouteData._();
}
