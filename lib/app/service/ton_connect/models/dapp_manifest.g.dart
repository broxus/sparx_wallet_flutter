// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dapp_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DappManifest _$DappManifestFromJson(Map<String, dynamic> json) =>
    _DappManifest(
      url: json['url'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      termsOfUseUrl: json['termsOfUseUrl'] as String?,
      privacyPolicyUrl: json['privacyPolicyUrl'] as String?,
    );

Map<String, dynamic> _$DappManifestToJson(_DappManifest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'termsOfUseUrl': instance.termsOfUseUrl,
      'privacyPolicyUrl': instance.privacyPolicyUrl,
    };
