import 'dart:async';

import 'package:app/app/service/app_version_service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/feature/presets_config/domain/presets_config_reader.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/latest_version_finder.dart';
import 'package:app/feature/update_version/domain/storage/update_version_storage_service.dart';
import 'package:app/feature/update_version/domain/update_status_checker.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/foundation.dart';
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
    this._updateVersionStorageService,
    this._appVersionService,
  );

  final PresetsConfigReader _presetsConfigReader;
  final UpdateStatusChecker _updateStatusChecker;
  final LatestVersionFinder _latestVersionFinder;
  final UpdateVersionStorageService _updateVersionStorageService;
  final AppVersionService _appVersionService;

  @visibleForTesting
  Future<void>? initCall;

  static final _logger = Logger('UpdateService');

  // BehaviorSubject for update requests
  final BehaviorSubject<UpdateRequest?> _updateRequestSubject =
      BehaviorSubject.seeded(null);

  /// Stream of update requests
  ValueStream<UpdateRequest?> get updateRequests =>
      _updateRequestSubject.stream;

  void init() {
    // Call initialization asynchronously and catch result through subject
    initCall ??= _init();
  }

  /// Initialize service and check for updates
  Future<void> _init() async {
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
      _updateRequestSubject.add(null);
      return;
    }

    if (status == UpdateStatus.warning && !_shouldShowWarning(rules)) {
      _logger.info('Warning update not shown due to frequency/delay rules');
      return;
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

  bool _shouldShowWarning(UpdateRules rules) {
    final warningCount = _updateVersionStorageService.warningCount() ?? 0;

    if (warningCount >= rules.warningShowTimes) {
      _logger.info(
        'Warning count exceeded: $warningCount >= ${rules.warningShowTimes}',
      );
      return false;
    }

    final warningLastTimeSecs =
        (_updateVersionStorageService.warningLastTime() ?? 0) ~/ 1000;

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

  Future<void> dismissWarning() async {
    if (_updateRequestSubject.valueOrNull?.status == UpdateStatus.warning) {
      final warningCount = _updateVersionStorageService.warningCount() ?? 0;

      _updateVersionStorageService
        ..updateWarningCount(warningCount + 1)
        ..updateWarningLastTime();

      _updateRequestSubject.add(null);
    }
  }

  void dispose() {
    _updateRequestSubject.close();
  }
}
