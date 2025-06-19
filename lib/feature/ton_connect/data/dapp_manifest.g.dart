// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dapp_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DappManifestImpl _$$DappManifestImplFromJson(Map<String, dynamic> json) =>
    _$DappManifestImpl(
      url: json['url'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      termsOfUseUrl: json['termsOfUseUrl'] as String?,
      privacyPolicyUrl: json['privacyPolicyUrl'] as String?,
    );

Map<String, dynamic> _$$DappManifestImplToJson(_$DappManifestImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'iconUrl': instance.iconUrl,
      'termsOfUseUrl': instance.termsOfUseUrl,
      'privacyPolicyUrl': instance.privacyPolicyUrl,
    };
