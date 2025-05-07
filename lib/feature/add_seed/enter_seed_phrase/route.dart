import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class EnterSeedPhraseRoute
    extends CompassRouteParameterless<EnterSeedPhraseRouteData> {
  EnterSeedPhraseRoute({
    required this.createSeedPasswordRoute,
  }) : super(
          name: 'enter-seed-phrase',
          path: 'enter-seed',
          builder: (context, _, __) => const EnterSeedPhraseWidget(),
          compassBaseRoutes: [createSeedPasswordRoute],
        );

  final CreateSeedPasswordRoute createSeedPasswordRoute;

  @override
  EnterSeedPhraseRouteData dataFabric() {
    return const EnterSeedPhraseRouteData();
  }
}

/// Data model for EnterSeedPhrase route
@freezed
class EnterSeedPhraseRouteData
    with _$EnterSeedPhraseRouteData
    implements CompassRouteData {
  const factory EnterSeedPhraseRouteData() = _EnterSeedPhraseRouteData;

  const EnterSeedPhraseRouteData._();
}
