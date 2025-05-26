import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/view/select_new_asset_page.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Query parameter name for the account address in the SelectNewAsset route
const _addressQueryParam = 'address';

@named
@Singleton(as: CompassBaseRoute)
class SelectNewAssetRoute extends CompassRoute<SelectNewAssetRouteData> {
  SelectNewAssetRoute()
      : super(
          path: '/select-new-asset',
          builder: (context, data, _) => SelectNewAssetPage(
            address: data.address,
          ),
        );

  @override
  SelectNewAssetRouteData fromQueryParams(Map<String, String> queryParams) {
    return SelectNewAssetRouteData(
      address: Address(
        address: queryParams[_addressQueryParam]!,
      ),
    );
  }
}

class SelectNewAssetRouteData implements CompassRouteDataQuery {
  const SelectNewAssetRouteData({
    required this.address,
  });

  /// Address of the account to select assets for
  final Address address;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
    };
  }
}
