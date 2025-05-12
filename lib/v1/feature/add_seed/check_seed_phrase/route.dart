import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/view/view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

const _seedPhraseQueryParam = 'seed';
const _seedNameQueryParam = 'seedName';

/// Route implementation for CheckSeedPhrase
@singleton
class CheckSeedPhraseRoute extends CompassRoute<CheckSeedPhraseRouteData> {
  CheckSeedPhraseRoute({
    required this.createSeedPasswordProfileRoute,
  }) : super(
          name: 'check-seed',
          builder: (context, data, _) => CheckSeedPhrasePage(
            seed: SeedPhraseModel(data.seedPhrase),
            name: data.name,
          ),
          compassBaseRoutes: [
            createSeedPasswordProfileRoute,
          ],
        );

  final CreateSeedPasswordRoute createSeedPasswordProfileRoute;

  @override
  CheckSeedPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return CheckSeedPhraseRouteData(
      seedPhrase: queryParams[_seedPhraseQueryParam]!,
      name: queryParams[name],
    );
  }
}

/// Route data for CheckSeedPhrase
@freezed
class CheckSeedPhraseRouteData
    with _$CheckSeedPhraseRouteData
    implements CompassRouteDataQuery {
  const factory CheckSeedPhraseRouteData({
    required String seedPhrase,
    required String? name,
  }) = _CheckSeedPhraseRouteData;

  const CheckSeedPhraseRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final name = this.name;

    return {
      _seedPhraseQueryParam: seedPhrase,
      if (name != null) _seedNameQueryParam: name,
    };
  }
}
