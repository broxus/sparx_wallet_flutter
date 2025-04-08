import 'package:app/feature/presets_config/data/release_note.dart';
import 'package:app/feature/presets_config/data/release_notes.dart';
import 'package:app/feature/update_version/domain/latest_version_finder.dart';
import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LatestVersionFinder latestVersionFinder;
  late VersionComparator versionComparator;

  setUp(() {
    versionComparator = VersionComparator();
    latestVersionFinder = LatestVersionFinder(versionComparator);
  });

  group('findLatestVersion', () {
    test('returns null when release notes are null', () {
      // Act
      final result = latestVersionFinder.findLatestVersion(
        null,
        '1.0.0',
      );

      // Assert
      expect(result, isNull);
    });

    test('returns null when no available versions exist', () {
      // Arrange
      const releaseNotes = ReleaseNotes(
        notes: {
          '1.0.0': ReleaseNote(available: false, info: 'Version 1.0.0'),
          '1.1.0': ReleaseNote(available: false, info: 'Version 1.1.0'),
        },
      );

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '0.9.0',
      );

      // Assert
      expect(result, isNull);
    });

    test('returns the latest available version when current version is lower',
        () {
      // Arrange
      const releaseNotes = ReleaseNotes(
        notes: {
          '1.0.0': ReleaseNote(available: true, info: 'Version 1.0.0'),
          '1.1.0': ReleaseNote(available: true, info: 'Version 1.1.0'),
          '1.2.0': ReleaseNote(available: false, info: 'Version 1.2.0'),
        },
      );

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '0.9.0',
      );

      // Assert
      expect(result, isNotNull);
      expect(result!.key, '1.1.0');
      expect(result.value.info, 'Version 1.1.0');
    });

    test('returns null when current version is greater than latest available',
        () {
      // Arrange
      const releaseNotes = ReleaseNotes(
        notes: {
          '1.0.0': ReleaseNote(available: true, info: 'Version 1.0.0'),
          '1.1.0': ReleaseNote(available: true, info: 'Version 1.1.0'),
        },
      );

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '1.2.0',
      );

      // Assert
      expect(result, isNull);
    });

    test('returns null when current version is equal to latest available', () {
      // Arrange
      const releaseNotes = ReleaseNotes(
        notes: {
          '1.0.0': ReleaseNote(available: true, info: 'Version 1.0.0'),
          '1.1.0': ReleaseNote(available: true, info: 'Version 1.1.0'),
        },
      );

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '1.1.0',
      );

      // Assert
      expect(result, isNull);
    });

    test('selects version with highest version number when multiple available',
        () {
      // Arrange
      const releaseNotes = ReleaseNotes(
        notes: {
          '1.0.0': ReleaseNote(available: true, info: 'Version 1.0.0'),
          '1.1.0': ReleaseNote(available: true, info: 'Version 1.1.0'),
          '0.9.0': ReleaseNote(available: true, info: 'Version 0.9.0'),
          '1.2.0': ReleaseNote(available: true, info: 'Version 1.2.0'),
        },
      );

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '0.8.0',
      );

      // Assert
      expect(result, isNotNull);
      expect(result!.key, '1.2.0');
      expect(result.value.info, 'Version 1.2.0');
    });

    test('returns null when notes map is empty', () {
      // Arrange
      const releaseNotes = ReleaseNotes(notes: {});

      // Act
      final result = latestVersionFinder.findLatestVersion(
        releaseNotes,
        '1.0.0',
      );

      // Assert
      expect(result, isNull);
    });
  });
}
