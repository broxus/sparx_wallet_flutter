import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/create_seed/route.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:injectable/injectable.dart';

const _commandQueryParam = 'command';

/// Route that allows CREATE or ENTER seed phrase with entering name.
@named
@Singleton(as: CompassBaseRoute)
class EnterSeedNameRoute extends CompassRoute<EnterSeedNameRouteData> {
  EnterSeedNameRoute(
    @Named.from(CreateSeedRoute) CompassBaseRoute createSeedRoute,
    @Named.from(EnterSeedPhraseRoute) CompassBaseRoute enterSeedPhraseRoute,
  ) : super(
          path: '/enter-seed-name',
          isSaveLocation: true,
          builder: (_, data, __) => EnterSeedNamePage(
            command: data.command,
          ),
          compassBaseRoutes: [
            createSeedRoute,
            enterSeedPhraseRoute,
          ],
        );

  @override
  EnterSeedNameRouteData fromQueryParams(Map<String, String> queryParams) {
    return EnterSeedNameRouteData(
      command: EnterSeedNameCommand.values.byName(
        queryParams[_commandQueryParam]!,
      ),
    );
  }
}

class EnterSeedNameRouteData implements CompassRouteDataQuery {
  const EnterSeedNameRouteData({
    required this.command,
  });

  final EnterSeedNameCommand command;

  @override
  Map<String, String> toQueryParams() {
    return {
      _commandQueryParam: command.name,
    };
  }
}
