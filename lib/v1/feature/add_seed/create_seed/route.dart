import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/v1/feature/add_seed/create_seed/view/create_seed_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

const _seedNameQueryParam = 'seedName';

/// Route that allows to create a seed phrase with/without entering name.
@singleton
@Deprecated('Use v2 version')
class CreateSeedRoute extends CompassRoute<CreateSeedRouteData> {
  @Deprecated('Use v2 version')
  CreateSeedRoute({
    required this.checkSeedPhraseRoute,
    required this.createSeedPasswordRoute,
  }) : super(
          name: 'create-seed',
          builder: (_, data, ___) => CreateSeedPage(
            name: data.seedName,
          ),
          compassBaseRoutes: [
            checkSeedPhraseRoute,
            createSeedPasswordRoute,
          ],
        );

  final CheckSeedPhraseRoute checkSeedPhraseRoute;
  final CreateSeedPasswordRoute createSeedPasswordRoute;

  @override
  CreateSeedRouteData fromQueryParams(Map<String, String> queryParams) {
    return CreateSeedRouteData(
      seedName: queryParams[_seedNameQueryParam],
    );
  }
}

/// Route data for CreateSeedNamed
@freezed
class CreateSeedRouteData
    with _$CreateSeedRouteData
    implements CompassRouteDataQuery {
  const factory CreateSeedRouteData({
    required String? seedName,
  }) = _CreateSeedRouteData;

  const CreateSeedRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final seedName = this.seedName;

    return {
      if (seedName != null) _seedNameQueryParam: seedName,
    };
  }
}
