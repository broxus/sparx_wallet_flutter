import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/add_seed/check_seed_phrase/view/view.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/widgets/widgets.dart';
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
        compassBaseRoutes: [createSeedPasswordProfileRoute],
        builder: (context, data, _) => ProtectedContent(
          child: CheckSeedPhrasePage(seed: data.seedPhrase, name: data.name),
        ),
      );

  @override
  CheckSeedPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return CheckSeedPhraseRouteData(
      seedPhrase: SecureString.fromJson(
        jsonDecode(queryParams[_seedPhraseQueryParam]!) as Map<String, dynamic>,
      ),
      name: queryParams[_seedNameQueryParam],
    );
  }
}

class CheckSeedPhraseRouteData implements CompassRouteDataQuery {
  const CheckSeedPhraseRouteData({
    required this.seedPhrase,
    required this.name,
  });

  final SecureString seedPhrase;
  final String? name;

  @override
  Map<String, String> toQueryParams() {
    final name = this.name;

    return {
      _seedPhraseQueryParam: jsonEncode(seedPhrase.toJson()),
      if (name != null) _seedNameQueryParam: name,
    };
  }
}
