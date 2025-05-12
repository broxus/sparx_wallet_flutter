import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:string_extensions/string_extensions.dart';

part 'route.freezed.dart';

const _seedNameQueryParam = 'seedName';
const _isOnboardingQueryParam = 'isOnboarding';

/// Route that allows to enter a seed phrase without entering name.
@singleton
class EnterSeedPhraseRoute extends CompassRoute<EnterSeedPhraseRouteData> {
  EnterSeedPhraseRoute({
    required this.createSeedPasswordRoute,
  }) : super(
          name: 'enter-seed-phrase',
          builder: (context, _, __) => const EnterSeedPhraseWidget(),
          compassBaseRoutes: [createSeedPasswordRoute],
        );

  final CreateSeedPasswordRoute createSeedPasswordRoute;

  @override
  EnterSeedPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return EnterSeedPhraseRouteData(
      seedName: queryParams[_seedNameQueryParam],
      isOnboarding: queryParams[_isOnboardingQueryParam]?.toBool ?? false,
    );
  }
}

/// Data model for EnterSeedPhrase route
@freezed
class EnterSeedPhraseRouteData
    with _$EnterSeedPhraseRouteData
    implements CompassRouteDataQuery {
  const factory EnterSeedPhraseRouteData({
    required bool isOnboarding,
    required String? seedName,
  }) = _EnterSeedPhraseRouteData;

  const EnterSeedPhraseRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final seedName = this.seedName;

    return {
      _isOnboardingQueryParam: isOnboarding.toString(),
      if (seedName != null) _seedNameQueryParam: seedName,
    };
  }
}
