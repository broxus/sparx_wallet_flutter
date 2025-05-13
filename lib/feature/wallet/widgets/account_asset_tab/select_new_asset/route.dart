import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/view/select_new_asset_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Query parameter name for the account address in the SelectNewAsset route
const selectNewAssetAddressQueryParam = 'selectNewAssetAddress';

@named
@Singleton(as: CompassBaseRoute)
class SelectNewAssetRoute extends CompassRoute<SelectNewAssetRouteData> {
  SelectNewAssetRoute()
      : super(
          name: 'select-new-asset',
          builder: (context, data, _) => SelectNewAssetPage(
            address: data.address,
          ),
        );

  @override
  SelectNewAssetRouteData fromQueryParams(Map<String, String> queryParams) {
    return SelectNewAssetRouteData(
      address: Address(
        address: queryParams[selectNewAssetAddressQueryParam]!,
      ),
    );
  }
}

/// Data model for SelectNewAsset route
@freezed
class SelectNewAssetRouteData
    with _$SelectNewAssetRouteData
    implements CompassRouteDataQuery {
  const factory SelectNewAssetRouteData({
    /// Address of the account to select assets for
    required Address address,
  }) = _SelectNewAssetRouteData;

  const SelectNewAssetRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      selectNewAssetAddressQueryParam: address.address,
    };
  }
}
