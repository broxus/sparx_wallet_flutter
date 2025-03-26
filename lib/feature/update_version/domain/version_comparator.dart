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

  List<int> _parseVersion(String version) {
    final String localVersion;
    if (version.contains('+')) {
      localVersion = version.split('+').first;
    } else {
      localVersion = version;
    }

    return localVersion.split('.').map(int.tryParse).whereNotNull().toList();
  }
}
