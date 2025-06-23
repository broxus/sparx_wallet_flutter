import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/app/service/bootstrap/configurators/biometry.dart';
import 'package:app/app/service/bootstrap/configurators/connection.dart';
import 'package:app/app/service/bootstrap/configurators/encrypted_storage.dart';
import 'package:app/app/service/bootstrap/configurators/features.dart';
import 'package:app/app/service/bootstrap/configurators/migrate_storage.dart';
import 'package:app/app/service/bootstrap/configurators/nekoton.dart';
import 'package:app/app/service/bootstrap/configurators/ntp.dart';
import 'package:app/app/service/bootstrap/configurators/storage_services.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/core/sentry.dart';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

typedef AsyncFunc = Future<void> Function();

/// Service that allows initialize app step by step and re-run some operations
/// if they failed.
@singleton
class BootstrapService {
  BootstrapService(
    this._presetsConnectionService,
    this._biometryConfigurator,
    this._connectionConfigurator,
    this._encryptedStorageConfigurator,
    this._featureServicesConfigurator,
    this._migrateConfigurator,
    this._storageServicesConfigurator,
    this._nekotonConfigurator,
    this._ntpConfigurator,
  );

  final PresetsConnectionService _presetsConnectionService;
  final BiometryConfigurator _biometryConfigurator;
  final ConnectionConfigurator _connectionConfigurator;
  final EncryptedStorageConfigurator _encryptedStorageConfigurator;
  final FeatureServicesConfigurator _featureServicesConfigurator;
  final MigrateConfigurator _migrateConfigurator;
  final StorageConfigurator _storageServicesConfigurator;
  final NekotonConfigurator _nekotonConfigurator;
  final NtpConfigurator _ntpConfigurator;

  final _log = Logger('bootstrap');

  final _bootstrapStepSubject =
      BehaviorSubject<BootstrapSteps>.seeded(BootstrapSteps.empty);

  Stream<BootstrapSteps> get bootstrapStepStream => _bootstrapStepSubject;

  BootstrapSteps get bootstrapStep => _bootstrapStepSubject.value;

  bool get isConfigured => bootstrapStep == BootstrapSteps.completed;

  Future<bool> init(AppBuildType appBuildType) async {
    try {
      await _coreStep(appBuildType);

      _bootstrapStepSubject.add(BootstrapSteps.remoteNetworks);
      await _remoteNetworksStep();

      _bootstrapStepSubject.add(BootstrapSteps.storage);
      await _storageStep();

      _bootstrapStepSubject.add(BootstrapSteps.connection);
      await _connectionStep();

      _bootstrapStepSubject.add(BootstrapSteps.features);
      await _featureStep();

      SentryWorker.instance.configureScope();

      _bootstrapStepSubject.add(BootstrapSteps.completed);

      return true;
    } catch (e, t) {
      _log.severe('init', e, t);
      return false;
    }
  }

  Future<void> rerunFailedSteps() async {
    var failedStep = bootstrapStep;
    final failedStepIndex = failedStep.index;

    if (failedStep == BootstrapSteps.completed) return;

    // ignore: avoid-missing-enum-constant-in-map
    final steps = <BootstrapSteps, AsyncFunc>{
      BootstrapSteps.remoteNetworks: _remoteNetworksStep,
      BootstrapSteps.storage: _storageStep,
      BootstrapSteps.connection: _connectionStep,
      BootstrapSteps.features: _featureStep,
    };

    try {
      for (var i = failedStepIndex; i < BootstrapSteps.completed.index; i++) {
        final currentStep = BootstrapSteps.values[i];
        // we do not update step during initialization to avoid changing page
        // in ui
        failedStep = currentStep;
        await steps[currentStep]!();
      }

      _bootstrapStepSubject.add(BootstrapSteps.completed);
    } catch (e, t) {
      _log.severe('rerunFailedSteps:${failedStep.name}', e, t);
      // update ui
      _bootstrapStepSubject.add(failedStep);

      // allow cubit catch this error
      rethrow;
    }
  }

  /// This step can not be failed during initialization, so we do not let
  /// it to be re-runed (if failed - that's gg).
  Future<void> _coreStep(AppBuildType appBuildType) async {
    await _encryptedStorageConfigurator.configure();
  }

  Future<void> _remoteNetworksStep() async {
    await _presetsConnectionService.fetchConnectionsList();
  }

  Future<void> _storageStep() async {
    await _migrateConfigurator.configure();
    await _storageServicesConfigurator.configure();
    await _ntpConfigurator.configure();
    await _nekotonConfigurator.configure();
    await _biometryConfigurator.configure();
  }

  Future<void> _connectionStep() async {
    await _connectionConfigurator.configure();
  }

  Future<void> _featureStep() async {
    await _featureServicesConfigurator.configure();
  }
}
