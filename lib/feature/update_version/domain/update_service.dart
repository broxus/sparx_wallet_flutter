import 'dart:async';

import 'package:app/app/service/app_version_service.dart';
import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/feature/presets_config/domain/presets_config_reader.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/latest_version_finder.dart';
import 'package:app/feature/update_version/domain/update_status_checker.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

/// Service for managing app updates
@singleton
class UpdateService {
  /// Creates a new update service
  UpdateService(
    this._presetsConfigReader,
    this._updateStatusChecker,
    this._latestVersionFinder,
    this._appStorage,
    this._appVersionService,
  );

  final PresetsConfigReader _presetsConfigReader;
  final UpdateStatusChecker _updateStatusChecker;
  final LatestVersionFinder _latestVersionFinder;
  final AppStorageService _appStorage;
  final AppVersionService _appVersionService;

  static final _logger = Logger('UpdateService');

  // BehaviorSubject for update requests
  final BehaviorSubject<UpdateRequest?> _updateRequestSubject =
      BehaviorSubject.seeded(null);

  /// Stream of update requests
  Stream<UpdateRequest?> get updateRequests => _updateRequestSubject.stream;

  /// Initialize service and check for updates
  Future<void> initialize() async {
    final rules = await _presetsConfigReader.getConfig(
      PresetConfigType.updateRules,
    );

    if (rules == null) {
      _logger.warning('Update rules not available');
      return;
    }

    final currentVersion = await _appVersionService.appVersion();
    final status = _updateStatusChecker.checkUpdateStatus(
      currentVersion,
      rules,
    );

    if (status == UpdateStatus.none) {
      _logger.info('No update required');
      return;
    }

    if (status == UpdateStatus.warning) {
      final warningCount = _appStorage.warningCount() ?? 0;

      if (!_shouldShowWarning(warningCount, rules)) {
        _logger.info('Warning update not shown due to frequency/delay rules');
        return;
      }

      _updateWarningDisplayInfo(warningCount);
    }

    final releaseNotes = await _presetsConfigReader.getConfig(
      PresetConfigType.releaseNotes,
    );

    final targetVersionNotes = _latestVersionFinder.findLatestVersion(
      releaseNotes,
      currentVersion,
    );

    // Create and emit update request
    final updateRequest = UpdateRequest(
      status: status,
      targetVersion: targetVersionNotes?.key,
      releaseNote: targetVersionNotes?.value,
    );

    _logger.info('Emitting update request: $updateRequest');
    _updateRequestSubject.add(updateRequest);
  }

  bool _shouldShowWarning(
    int warningCount,
    UpdateRules rules,
  ) {
    if (warningCount >= rules.warningShowTimes) {
      _logger.info(
        'Warning count exceeded: $warningCount >= ${rules.warningShowTimes}',
      );
      return false;
    }

    final warningLastTimeSecs = (_appStorage.warningLastTime() ?? 0) ~/ 1000;

    final nowSecs = NtpTime.now().millisecondsSinceEpoch ~/ 1000;
    final elapsedSecs = nowSecs - warningLastTimeSecs;

    if (elapsedSecs < rules.warningShowDelayS) {
      _logger.info(
        'Not enough time elapsed: $elapsedSecs < ${rules.warningShowDelayS}',
      );
      return false;
    }

    return true;
  }

  void _updateWarningDisplayInfo(
    int warningCount,
  ) {
    _appStorage
      ..updateWarningCount(warningCount + 1)
      ..updateWarningLastTime();
  }

  Future<void> dismissWarning() async {
    _updateRequestSubject.add(null);
  }

  void dispose() {
    _updateRequestSubject.close();
  }
}

final warningCountKey = StorageKey.updateStats('update_warning_count');
final warningLastTimeKey = StorageKey.updateStats('update_warning_last_time');

extension AppStorageServiceUpdateStatsEx on AppStorageService {
  int? warningCount() => getValue<int>(warningCountKey);
  int? warningLastTime() => getValue<int>(warningLastTimeKey);

  void updateWarningCount(int newCount) {
    addValue<int>(warningCountKey, newCount);
  }

  void updateWarningLastTime() {
    addValue<int>(warningLastTimeKey, NtpTime.now().millisecondsSinceEpoch);
  }
}
