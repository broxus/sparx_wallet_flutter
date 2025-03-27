import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late VersionComparator versionComparator;

  setUp(() {
    versionComparator = VersionComparator();
  });

  group('VersionComparator', () {
    test('compare should return positive when versionA > versionB', () {
      // Test major version difference
      expect(versionComparator.compare('2.0.0', '1.0.0'), isPositive);

      // Test minor version difference
      expect(versionComparator.compare('1.2.0', '1.1.0'), isPositive);

      // Test patch version difference
      expect(versionComparator.compare('1.0.2', '1.0.1'), isPositive);

      // Test different length versions
      expect(versionComparator.compare('1.0.0.1', '1.0.0'), isPositive);
    });

    test('compare should return zero when versionA == versionB', () {
      expect(versionComparator.compare('1.0.0', '1.0.0'), isZero);
      expect(versionComparator.compare('1.2.3', '1.2.3'), isZero);

      // Test different length but equivalent versions
      expect(versionComparator.compare('1.0.0.0', '1.0.0'), isZero);
    });

    test('compare should return negative when versionA < versionB', () {
      // Test major version difference
      expect(versionComparator.compare('1.0.0', '2.0.0'), isNegative);

      // Test minor version difference
      expect(versionComparator.compare('1.1.0', '1.2.0'), isNegative);

      // Test patch version difference
      expect(versionComparator.compare('1.0.1', '1.0.2'), isNegative);

      // Test different length versions
      expect(versionComparator.compare('1.0.0', '1.0.0.1'), isNegative);
    });

    test('compare should handle invalid version strings gracefully', () {
      // Should return 0 (equal) for invalid versions
      expect(versionComparator.compare('invalid', '1.0.0'), isNegative);
      expect(versionComparator.compare('1.0.0', 'invalid'), isPositive);
      expect(versionComparator.compare('invalid', 'invalid'), isZero);
    });

    test('compare should handle invalid version strings gracefully', () {
      // Should return 0 (equal) for invalid versions
      expect(versionComparator.compare('invalid', '1.0.0'), isNegative);
      expect(versionComparator.compare('1.0.0', 'invalid'), isPositive);
      expect(versionComparator.compare('invalid', 'invalid'), isZero);
    });

    test('compare should handle versions with build numbers (+ suffix)', () {
      // Test positive cases with build numbers
      expect(versionComparator.compare('2.0.0+13', '1.0.0'), isPositive);
      expect(versionComparator.compare('1.2.0+42', '1.1.0+99'), isPositive);
      expect(versionComparator.compare('1.0.0+13', '1.0.0'), isZero);

      // Test negative cases with build numbers
      expect(versionComparator.compare('1.0.0+13', '2.0.0'), isNegative);
      expect(versionComparator.compare('1.1.0+99', '1.2.0+1'), isNegative);

      // Test zero (equal) cases with build numbers
      expect(versionComparator.compare('1.0.0+13', '1.0.0+42'), isZero);
      expect(versionComparator.compare('1.2.3+1', '1.2.3+999'), isZero);

      // Test mixed cases (one version with build number, one without)
      expect(versionComparator.compare('1.0.0', '1.0.0+13'), isZero);
      expect(versionComparator.compare('1.2.3+1', '1.2.3'), isZero);

      // Test complex cases
      expect(versionComparator.compare('2.1.0+13', '1.9.9+999'), isPositive);
      expect(versionComparator.compare('1.9.9+999', '2.0.0+1'), isNegative);
    });
  });
}
