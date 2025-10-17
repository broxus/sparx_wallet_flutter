import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/check_seed_phrase/view/view.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:injectable/injectable.dart';

const _seedPhraseQueryParam = 'seed';
const _seedNameQueryParam = 'seedName';

/// Route implementation for CheckSeedPhrase
@named
@Singleton(as: CompassBaseRoute)
class CheckSeedPhraseRoute extends CompassRoute<CheckSeedPhraseRouteData> {
  CheckSeedPhraseRoute(
    @Named.from(CreateSeedPasswordRoute)
    CompassBaseRoute createSeedPasswordProfileRoute,
  ) : super(
        path: '/check-seed',
        builder: (context, data, _) => CheckSeedPhrasePage(
          seed: SeedPhraseModel(data.seedPhrase),
          name: data.name,
        ),
        compassBaseRoutes: [createSeedPasswordProfileRoute],
      );

  @override
  CheckSeedPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return CheckSeedPhraseRouteData(
      seedPhrase: queryParams[_seedPhraseQueryParam]!,
      name: queryParams[name],
    );
  }
}

class CheckSeedPhraseRouteData implements CompassRouteDataQuery {
  const CheckSeedPhraseRouteData({
    required this.seedPhrase,
    required this.name,
  });

  final String seedPhrase;
  final String? name;

  @override
  Map<String, String> toQueryParams() {
    final name = this.name;

    return {
      _seedPhraseQueryParam: seedPhrase,
      if (name != null) _seedNameQueryParam: name,
    };
  }
}
