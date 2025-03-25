import 'package:app/core/app_build_type.dart';
import 'package:app/feature/presets_config/data/model/connection_network_dto.dart';
import 'package:app/feature/presets_config/data/model/release_notes.dart';
import 'package:app/feature/presets_config/data/model/update_rules.dart';

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

  final String name;
  final String storageKey;
  final T Function(Map<String, dynamic>) mapper;

  String getFileName(AppBuildType buildType) {
    final suffix = switch (buildType) {
      AppBuildType.production => 'prod',
      _ => 'dev',
    };
    return '${name}_$suffix.json';
  }
}
