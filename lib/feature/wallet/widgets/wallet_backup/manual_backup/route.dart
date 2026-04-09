import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/secure_string_service.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/check_phrase/route.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/manual_backup/manual_back_up_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class ManualBackupRoute extends CompassRoute<ManualBackupRouteData> {
  ManualBackupRoute(
    @Named.from(CheckPhraseRoute) CompassBaseRoute checkPhraseRoute,
  ) : super(
        path: '/manual-backup',
        builder: (context, data, __) => ManualBackupScreen(
          seedPhrase: data.seedPhrase,
          address: data.address,
        ),
        compassBaseRoutes: [checkPhraseRoute],
      );

  @override
  ManualBackupRouteData fromQueryParams(Map<String, String> queryParams) {
    return ManualBackupRouteData(
      seedPhrase: SecureString.fromJson(
        jsonDecode(queryParams['seedPhrase']!) as Map<String, dynamic>,
      ),
      address: queryParams['address'] ?? '',
    );
  }
}

class ManualBackupRouteData implements CompassRouteDataQuery {
  const ManualBackupRouteData({
    required this.seedPhrase,
    required this.address,
  });

  final SecureString seedPhrase;
  final String address;

  @override
  Map<String, String> toQueryParams() {
    return {'seedPhrase': jsonEncode(seedPhrase.toJson()), 'address': address};
  }
}
