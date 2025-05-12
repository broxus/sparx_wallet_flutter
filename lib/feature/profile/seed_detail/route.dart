import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/profile/key_detail/route.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const seedDetailPublicKeyQueryParam = 'publicKey';

@singleton
class SeedDetailRoute extends CompassRoute<SeedDetailRouteData> {
  SeedDetailRoute({
    required this.keyDetailRoute,
  }) : super(
          name: 'seed-detail',
          builder: (context, data, _) => SeedDetailPageWidget(
            publicKey: data.publicKey,
          ),
          compassBaseRoutes: [keyDetailRoute],
        );

  final KeyDetailRoute keyDetailRoute;

  @override
  SeedDetailRouteData fromQueryParams(Map<String, String> queryParams) {
    return SeedDetailRouteData(
      publicKey: PublicKey(
        publicKey: queryParams[seedDetailPublicKeyQueryParam]!,
      ),
    );
  }
}

/// Data model for SeedDetail route
@freezed
class SeedDetailRouteData
    with _$SeedDetailRouteData
    implements CompassRouteDataQuery {
  const factory SeedDetailRouteData({
    /// PublicKey of seed
    required PublicKey publicKey,
  }) = _SeedDetailRouteData;

  const SeedDetailRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      seedDetailPublicKeyQueryParam: publicKey.publicKey,
    };
  }
}
