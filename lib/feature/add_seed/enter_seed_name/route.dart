import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_seed/route.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/feature/add_seed/import_wallet/route.dart';
import 'package:injectable/injectable.dart';

const _commandQueryParam = 'command';

/// Route that allows CREATE or ENTER seed phrase with entering name.
@named
@Singleton(as: CompassBaseRoute)
class EnterSeedNameRoute extends CompassRoute<EnterSeedNameRouteData> {
  EnterSeedNameRoute(
    @Named.from(CreateSeedRoute) CompassBaseRoute createSeedRoute,
    @Named.from(EnterSeedPhraseRoute) CompassBaseRoute enterSeedPhraseRoute,
    @Named.from(ImportWalletRoute) CompassBaseRoute importWalletRoute,
  ) : super(
        path: '/enter-seed-name',
        isSaveLocation: true,
        compassBaseRoutes: [
          createSeedRoute,
          enterSeedPhraseRoute,
          importWalletRoute,
        ],
        builder: (_, data, __) => EnterSeedNamePage(command: data.command),
      );

  @override
  EnterSeedNameRouteData fromQueryParams(Map<String, String> queryParams) {
    final command = queryParams.require(_commandQueryParam);

    return EnterSeedNameRouteData(
      command: EnterSeedNameCommand.values.byName(command),
    );
  }
}

class EnterSeedNameRouteData implements CompassRouteDataQuery {
  const EnterSeedNameRouteData({required this.command});

  final EnterSeedNameCommand command;

  @override
  Map<String, String> toQueryParams() {
    return {_commandQueryParam: command.name};
  }
}
