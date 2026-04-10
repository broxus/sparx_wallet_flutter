import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen.dart';
import 'package:app/widgets/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:string_extensions/string_extensions.dart';

const _seedNameQueryParam = 'seedName';
const _isOnboardingQueryParam = 'isOnboarding';

@named
@Singleton(as: CompassBaseRoute)
class ImportWalletRoute extends CompassRoute<ImportWalletRouteData> {
  ImportWalletRoute(
    @Named.from(EnterSeedPhraseRoute) CompassBaseRoute enterSeedPhraseRoute,
    @Named.from(CreateSeedOnboardingPasswordRoute)
    CompassBaseRoute createSeedOnboardingPasswordRoute,
    @Named.from(CreateSeedPasswordRoute)
    CompassBaseRoute createSeedPasswordRoute,
  ) : super(
        path: '/import-wallet',
        isSaveLocation: true,
        compassBaseRoutes: [
          enterSeedPhraseRoute,
          createSeedOnboardingPasswordRoute,
          createSeedPasswordRoute,
        ],
        builder: (context, data, __) => ProtectedContent(
          child: ImportWalletScreen(
            isOnboarding: data.isOnboarding,
            seedName: data.seedName,
          ),
        ),
      );

  @override
  ImportWalletRouteData fromQueryParams(Map<String, String> queryParams) {
    return ImportWalletRouteData(
      seedName: queryParams[_seedNameQueryParam],
      isOnboarding: queryParams[_isOnboardingQueryParam]?.toBool ?? false,
    );
  }
}

class ImportWalletRouteData implements CompassRouteDataQuery {
  const ImportWalletRouteData({required this.isOnboarding, this.seedName});

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
