import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/update_status_checker.dart';
import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UpdateStatusChecker updateStatusChecker;
  late VersionComparator versionComparator;

  setUp(() {
    versionComparator = VersionComparator();
    updateStatusChecker = UpdateStatusChecker(versionComparator);
  });

  group('UpdateStatusChecker', () {
    const testRules = UpdateRules(
      blockingVersion: '1.0.0',
      warningVersion: '1.5.0',
      warningShowTimes: 3,
      warningShowDelayS: 1800,
    );

    test(
      'should return blocking status when current version <= blocking version',
      () {
        // Act
        final result = updateStatusChecker.checkUpdateStatus(
          '0.9.0',
          testRules,
        );

        // Assert
        expect(result, equals(UpdateStatus.blocking));
      },
    );

    test(
      'should return warning status when current version <= warning version'
      ' but > blocking version',
      () {
        // Act
        final result = updateStatusChecker.checkUpdateStatus(
          '1.2.0',
          testRules,
        );

        // Assert
        expect(result, equals(UpdateStatus.warning));
      },
    );

    test(
      'should return none status when current version > warning version',
      () {
        // Act
        final result = updateStatusChecker.checkUpdateStatus(
          '1.6.0',
          testRules,
        );

        // Assert
        expect(result, equals(UpdateStatus.none));
      },
    );
  });
}
