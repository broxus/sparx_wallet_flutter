import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/secure_string_service.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/check_phrase_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class CheckPhraseRoute extends CompassRoute<CheckPhraseRouteData> {
  CheckPhraseRoute()
    : super(
        path: '/check-phrase',
        builder: (context, data, __) => CheckPhraseScreen(
          seedPhrase: data.seedPhrase,
          address: data.address,
        ),
      );

  @override
  CheckPhraseRouteData fromQueryParams(Map<String, String> queryParams) {
    return CheckPhraseRouteData(
      seedPhrase: SecureString.fromJson(
        jsonDecode(queryParams['seedPhrase']!) as Map<String, dynamic>,
      ),
      address: queryParams['address'] ?? '',
    );
  }
}

class CheckPhraseRouteData implements CompassRouteDataQuery {
  const CheckPhraseRouteData({required this.seedPhrase, required this.address});

  final SecureString seedPhrase;
  final String address;

  @override
  Map<String, String> toQueryParams() {
    return {'seedPhrase': jsonEncode(seedPhrase.toJson()), 'address': address};
  }
}
