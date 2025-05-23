import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/account_detail/view/account_detail_page.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _addressQueryParam = 'address';

@named
@Singleton(as: CompassBaseRoute)
class AccountDetailRoute extends CompassRoute<AccountDetailRouteData> {
  AccountDetailRoute()
      : super(
          path: '/account-detail',
          isSaveLocation: true,
          isBottomNavigationBarVisible: true,
          builder: (context, data, _) => AccountDetailPage(
            address: data.address,
          ),
        );

  @override
  AccountDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return AccountDetailRouteData(
      address: Address(
        address: queryParams[_addressQueryParam]!,
      ),
    );
  }
}

class AccountDetailRouteData implements CompassRouteDataQuery {
  const AccountDetailRouteData({
    required this.address,
  });

  /// Address of account
  final Address address;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
    };
  }
}
