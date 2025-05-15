import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/v1/feature/add_seed/create_seed/view/create_seed_page.dart';
import 'package:injectable/injectable.dart';

const _seedNameQueryParam = 'seedName';

/// Route that allows to create a seed phrase with/without entering name.
@named
@Singleton(as: CompassBaseRoute)
@Deprecated('Use v2 version')
class CreateSeedRoute extends CompassRoute<CreateSeedRouteData> {
  @Deprecated('Use v2 version')
  CreateSeedRoute(
    @Named.from(CheckSeedPhraseRoute) CompassBaseRoute checkSeedPhraseRoute,
    @Named.from(CreateSeedPasswordRoute)
    CompassBaseRoute createSeedPasswordRoute,
  ) : super(
          path: '/create-seed',
          isSaveLocation: true,
          builder: (_, data, ___) => CreateSeedPage(
            name: data.seedName,
          ),
          compassBaseRoutes: [
            checkSeedPhraseRoute,
            createSeedPasswordRoute,
          ],
        );

  @override
  CreateSeedRouteData fromQueryParams(Map<String, String> queryParams) {
    return CreateSeedRouteData(
      seedName: queryParams[_seedNameQueryParam],
    );
  }
}

class CreateSeedRouteData implements CompassRouteDataQuery {
  const CreateSeedRouteData({
    required this.seedName,
  });

  final String? seedName;

  @override
  Map<String, String> toQueryParams() {
    final seedName = this.seedName;

    return {
      if (seedName != null) _seedNameQueryParam: seedName,
    };
  }
}
