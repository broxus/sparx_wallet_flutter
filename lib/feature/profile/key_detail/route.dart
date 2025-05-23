import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/account_detail/route.dart';
import 'package:app/feature/profile/key_detail/view/key_detail_page.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _publicKeyQueryParam = 'publicKey';

@named
@Singleton(as: CompassBaseRoute)
class KeyDetailRoute extends CompassRoute<KeyDetailRouteData> {
  KeyDetailRoute(
    @Named.from(AccountDetailRoute) CompassBaseRoute accountDetailRoute,
  ) : super(
          path: '/key-detail',
          isSaveLocation: true,
          isBottomNavigationBarVisible: true,
          builder: (context, data, _) => KeyDetailPage(
            publicKey: data.publicKey,
          ),
          compassBaseRoutes: [accountDetailRoute],
        );

  @override
  KeyDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return KeyDetailRouteData(
      publicKey: PublicKey(
        publicKey: queryParams[_publicKeyQueryParam]!,
      ),
    );
  }
}

class KeyDetailRouteData implements CompassRouteDataQuery {
  const KeyDetailRouteData({
    required this.publicKey,
  });

  /// PublicKey of key
  final PublicKey publicKey;

  @override
  Map<String, String> toQueryParams() {
    return {
      _publicKeyQueryParam: publicKey.publicKey,
    };
  }
}
