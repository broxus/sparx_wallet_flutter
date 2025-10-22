// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton_assets_manifest_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TonAssetsManifestVersion _$TonAssetsManifestVersionFromJson(
  Map<String, dynamic> json,
) => _TonAssetsManifestVersion(
  major: (json['major'] as num).toInt(),
  minor: (json['minor'] as num).toInt(),
  patch: (json['patch'] as num).toInt(),
);

Map<String, dynamic> _$TonAssetsManifestVersionToJson(
  _TonAssetsManifestVersion instance,
) => <String, dynamic>{
  'major': instance.major,
  'minor': instance.minor,
  'patch': instance.patch,
};
