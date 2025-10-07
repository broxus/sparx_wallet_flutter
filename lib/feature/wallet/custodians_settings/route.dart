import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_page.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _addressQueryParam = 'custodiansSettingsAddress';

@named
@Singleton(as: CompassBaseRoute)
class CustodiansSettingsRoute
    extends CompassRoute<CustodiansSettingsRouteData> {
  CustodiansSettingsRoute()
      : super(
          path: '/custodians-settings',
          builder: (context, data, _) => CustodiansSettingsPage(
            address: data.address,
          ),
        );

  @override
  CustodiansSettingsRouteData fromQueryParams(Map<String, String> queryParams) {
    return CustodiansSettingsRouteData(
      address: Address(address: queryParams[_addressQueryParam]!),
    );
  }
}

class CustodiansSettingsRouteData implements CompassRouteDataQuery {
  const CustodiansSettingsRouteData({
    required this.address,
  });

  final Address address;

  @override
  Map<String, String> toQueryParams() => {
        _addressQueryParam: address.toString(),
      };
}
