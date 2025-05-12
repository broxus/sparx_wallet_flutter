import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/account_detail/route.dart';
import 'package:app/feature/profile/key_detail/view/key_detail_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const keyDetailPublicKeyQueryParam = 'publicKey';

@singleton
class KeyDetailRoute extends CompassRoute<KeyDetailRouteData> {
  KeyDetailRoute({
    required this.accountDetailRoute,
  }) : super(
          name: 'key-detail',
          builder: (context, data, _) => KeyDetailPage(
            publicKey: data.publicKey,
          ),
          compassBaseRoutes: [accountDetailRoute],
        );

  final AccountDetailRoute accountDetailRoute;

  @override
  KeyDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return KeyDetailRouteData(
      publicKey: PublicKey(
        publicKey: queryParams[keyDetailPublicKeyQueryParam]!,
      ),
    );
  }
}

/// Data model for KeyDetail route
@freezed
class KeyDetailRouteData
    with _$KeyDetailRouteData
    implements CompassRouteDataQuery {
  const factory KeyDetailRouteData({
    /// PublicKey of key
    required PublicKey publicKey,
  }) = _KeyDetailRouteData;

  const KeyDetailRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      keyDetailPublicKeyQueryParam: publicKey.publicKey,
    };
  }
}
