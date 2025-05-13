import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/v1/feature/add_seed/create_seed/route.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

const _commandQueryParam = 'command';

/// Route that allows CREATE or ENTER seed phrase with entering name.
@named
@Singleton(as: CompassBaseRoute)
@Deprecated('Use v2 version')
class EnterSeedNameRoute extends CompassRoute<EnterSeedNameRouteData> {
  @Deprecated('Use v2 version')
  EnterSeedNameRoute(
    @Named.from(CreateSeedRoute) CompassBaseRoute createSeedRoute,
    @Named.from(EnterSeedPhraseRoute) CompassBaseRoute enterSeedPhraseRoute,
  ) : super(
          name: 'enter-seed-name',
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

/// Route data for EnterSeedName
@freezed
class EnterSeedNameRouteData
    with _$EnterSeedNameRouteData
    implements CompassRouteDataQuery {
  const factory EnterSeedNameRouteData({
    required EnterSeedNameCommand command,
  }) = _EnterSeedNameRouteData;

  const EnterSeedNameRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      _commandQueryParam: command.name,
    };
  }
}
