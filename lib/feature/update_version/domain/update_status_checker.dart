import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:injectable/injectable.dart';

/// Service for checking the update status based on version comparison
@injectable
class UpdateStatusChecker {
  /// Creates a new update status checker
  UpdateStatusChecker(this._versionComparator);

  final VersionComparator _versionComparator;

  /// Checks the current app version against the update rules
  /// Returns the appropriate update status
  UpdateStatus checkUpdateStatus(String currentVersion, UpdateRules rules) {
    final compareWithBlocking = _versionComparator.compare(
      currentVersion,
      rules.blockingVersion,
    );

    if (compareWithBlocking <= 0) {
      return UpdateStatus.blocking;
    }

    final compareWithWarning = _versionComparator.compare(
      currentVersion,
      rules.warningVersion,
    );

    if (compareWithWarning <= 0) {
      return UpdateStatus.warning;
    }

    return UpdateStatus.none;
  }
}
