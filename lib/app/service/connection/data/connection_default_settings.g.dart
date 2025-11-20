// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_default_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectionDefaultSettings _$ConnectionDefaultSettingsFromJson(
  Map<String, dynamic> json,
) => _ConnectionDefaultSettings(
  walletAccountNames: WalletDefaultAccountNames.fromJson(
    json['walletAccountNames'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ConnectionDefaultSettingsToJson(
  _ConnectionDefaultSettings instance,
) => <String, dynamic>{
  'walletAccountNames': instance.walletAccountNames.toJson(),
};
