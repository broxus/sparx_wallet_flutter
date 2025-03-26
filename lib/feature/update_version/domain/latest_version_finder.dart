import 'package:app/feature/presets_config/data/release_note.dart';
import 'package:app/feature/presets_config/data/release_notes.dart';
import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// A class responsible for finding the latest available version
/// from release notes.
@injectable
class LatestVersionFinder {
  /// Creates a new [LatestVersionFinder].
  LatestVersionFinder(this._versionComparator);

  final VersionComparator _versionComparator;
  static final _logger = Logger('LatestVersionFinder');

  /// Finds the latest available version entry in the release notes.
  ///
  /// Returns null if no available version is found or if the current version
  /// is greater than or equal to the latest available version.
  ///
  /// Parameters:
  /// - [releaseNotes]: The release notes to search in.
  /// - [currentVersion]: The current version of the app.
  MapEntry<String, ReleaseNote>? findLatestVersion(
    ReleaseNotes? releaseNotes,
    String currentVersion,
  ) {
    if (releaseNotes == null) {
      _logger.info('Release notes are null');
      return null;
    }

    var targetVersion = releaseNotes.notes.entries
        .where((e) => e.value.available)
        .sorted((a, b) => _versionComparator.compare(a.key, b.key))
        .lastOrNull;

    if (targetVersion != null &&
        _versionComparator.compare(currentVersion, targetVersion.key) >= 0) {
      _logger.info(
        'Current version $currentVersion is greater than or equal to '
        'latest available version ${targetVersion.key}',
      );
      targetVersion = null;
    }

    return targetVersion;
  }
}
