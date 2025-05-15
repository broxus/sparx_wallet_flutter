import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/key_detail/route.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_widget.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _publicKeyQueryParam = 'publicKey';

@named
@Singleton(as: CompassBaseRoute)
class SeedDetailRoute extends CompassRoute<SeedDetailRouteData> {
  SeedDetailRoute(
    @Named.from(KeyDetailRoute) CompassBaseRoute keyDetailRoute,
  ) : super(
          path: '/seed-detail',
          isSaveLocation: true,
          builder: (context, data, _) => SeedDetailPageWidget(
            publicKey: data.publicKey,
          ),
          compassBaseRoutes: [keyDetailRoute],
        );

  @override
  SeedDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return SeedDetailRouteData(
      publicKey: PublicKey(
        publicKey: queryParams[_publicKeyQueryParam]!,
      ),
    );
  }
}

class SeedDetailRouteData implements CompassRouteDataQuery {
  const SeedDetailRouteData({
    required this.publicKey,
  });

  /// PublicKey of seed
  final PublicKey publicKey;

  @override
  Map<String, String> toQueryParams() {
    return {
      _publicKeyQueryParam: publicKey.publicKey,
    };
  }
}
