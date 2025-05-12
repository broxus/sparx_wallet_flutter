import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/account_detail/view/account_detail_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const accountDetailAddressQueryParam = 'address';

@singleton
class AccountDetailRoute extends CompassRoute<AccountDetailRouteData> {
  AccountDetailRoute()
      : super(
          name: 'account-detail',
          builder: (context, data, _) => AccountDetailPage(
            address: data.address,
          ),
        );

  @override
  AccountDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return AccountDetailRouteData(
      address: Address(
        address: queryParams[accountDetailAddressQueryParam]!,
      ),
    );
  }
}

/// Data model for AccountDetail route
@freezed
class AccountDetailRouteData
    with _$AccountDetailRouteData
    implements CompassRouteDataQuery {
  const factory AccountDetailRouteData({
    /// Address of account
    required Address address,
  }) = _AccountDetailRouteData;

  const AccountDetailRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      accountDetailAddressQueryParam: address.address,
    };
  }
}
