import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/onboarding/screen/restore_backup/restore_backup_screen.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class RestoreBackupRoute
    extends CompassRouteParameterless<RestoreBackupRouteData> {
  RestoreBackupRoute()
    : super(
        path: '/restore-backup',
        isSaveLocation: true,
        builder: (context, _, __) => const RestoreBackupScreen(),
      );

  @override
  RestoreBackupRouteData createData() {
    return const RestoreBackupRouteData();
  }
}

class RestoreBackupRouteData implements CompassRouteData {
  const RestoreBackupRouteData();
}
