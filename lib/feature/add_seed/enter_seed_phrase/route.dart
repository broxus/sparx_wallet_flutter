import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_widget.dart';
import 'package:app/widgets/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:string_extensions/string_extensions.dart';

const _seedNameQueryParam = 'seedName';
const _isOnboardingQueryParam = 'isOnboarding';

/// Route that allows to enter a seed phrase without entering name.
@named
@Singleton(as: CompassBaseRoute)
class EnterSeedPhraseRoute extends CompassRoute<EnterSeedPhraseRouteData> {
  EnterSeedPhraseRoute(
    @Named.from(CreateSeedPasswordRoute)
    CompassBaseRoute createSeedPasswordRoute,
    @Named.from(CreateSeedOnboardingPasswordRoute)
    CompassBaseRoute createSeedOnboardingPasswordRoute,
  ) : super(
        path: '/enter-seed-phrase',
        isSaveLocation: true,
        compassBaseRoutes: [
          createSeedPasswordRoute,
          createSeedOnboardingPasswordRoute,
        ],
        builder: (context, data, __) => ProtectedContent(
          child: EnterSeedPhraseWidget(
            seedName: data.seedName,
            isOnboarding: data.isOnboarding,
          ),
        ),
      );

  @override
  EnterSeedPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return EnterSeedPhraseRouteData(
      seedName: queryParams[_seedNameQueryParam],
      isOnboarding: queryParams[_isOnboardingQueryParam]?.toBool ?? false,
    );
  }
}

class EnterSeedPhraseRouteData implements CompassRouteDataQuery {
  const EnterSeedPhraseRouteData({
    required this.isOnboarding,
    required this.seedName,
  });

  final bool isOnboarding;
  final String? seedName;

  @override
  Map<String, String> toQueryParams() {
    final seedName = this.seedName;

    return {
      _isOnboardingQueryParam: isOnboarding.toString(),
      if (seedName != null) _seedNameQueryParam: seedName,
    };
  }
}
