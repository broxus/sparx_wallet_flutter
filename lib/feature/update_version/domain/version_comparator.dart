import 'dart:math';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

/// Service for comparing version strings
@injectable
class VersionComparator {
  /// Compares two version-names.
  int compare(String versionA, String versionB) {
    final partsA = _parseVersion(versionA);
    final partsB = _parseVersion(versionB);

    // Ensure both lists have the same length by padding with zeros
    final maxLength = max(partsA.length, partsB.length);

    while (partsA.length < maxLength) {
      partsA.add(0);
    }

    while (partsB.length < maxLength) {
      partsB.add(0);
    }

    // Compare each part
    for (var i = 0; i < maxLength; i++) {
      final comparison = partsA[i].compareTo(partsB[i]);
      if (comparison != 0) {
        return comparison;
      }
    }

    return 0; // Versions are equal
  }

  /// Parses a version string into a list of integers.
  /// Handles various version formats including:
  /// - Standard semantic versions (1.2.3)
  /// - Versions with build numbers (1.2.3+45)
  /// - Versions with pre-release identifiers (1.2.3-beta.1)
  List<int> _parseVersion(String version) {
    final withoutBuild =
        version.contains('+') ? version.split('+').first : version;

    final withoutPreRelease = withoutBuild.contains('-')
        ? withoutBuild.split('-').first
        : withoutBuild;

    // Parse version components into integers, filter out non-numeric parts
    return withoutPreRelease
        .split('.')
        .map((part) => int.tryParse(part.trim()) ?? 0)
        .toList();
  }
}
