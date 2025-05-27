import 'package:app/core/app_build_type.dart';
import 'package:app/feature/presets_config/data/connection_network_dto.dart';
import 'package:app/feature/presets_config/data/release_notes.dart';
import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/generated/generated.dart';

/// Configuration types supported by the application.
///
/// This enum represents the different configuration types that can be loaded
/// from remote sources, cached storage, or bundled assets.
enum PresetConfigType<T> {
  connections<ConnectionNetworkDto>(
    name: 'connections',
    storageKey: 'connections_config',
    mapper: ConnectionNetworkDto.fromJson,
  ),
  updateRules<UpdateRules>(
    name: 'update_rules',
    storageKey: 'update_rules_config',
    mapper: UpdateRules.fromJson,
  ),
  releaseNotes<ReleaseNotes>(
    name: 'release_notes',
    storageKey: 'release_notes_config',
    mapper: ReleaseNotes.fromJson,
  );

  const PresetConfigType({
    required this.name,
    required this.storageKey,
    required this.mapper,
  });

  /// The name identifier for the configuration type.
  /// Used in the filename when loading from assets or remote sources.
  final String name;

  /// The key used for storing this configuration in secure storage.
  final String storageKey;

  /// Function to convert a JSON to the specific configuration type instance.
  final T Function(Map<String, dynamic>) mapper;

  String getFileName(AppBuildType buildType) {
    final suffix = switch (buildType) {
      AppBuildType.production => 'prod',
      _ => 'dev',
    };
    return '${name}_$suffix.json';
  }

  /// The key used for loading the configuration from local assets.
  String getLocalFileName() => switch (this) {
        PresetConfigType.connections => Assets.configs.connections,
        PresetConfigType.updateRules => Assets.configs.updateRules,
        PresetConfigType.releaseNotes => Assets.configs.releaseNotes,
      };
}
