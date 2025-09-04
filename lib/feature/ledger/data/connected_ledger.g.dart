// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connected_ledger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConnectedLedger _$ConnectedLedgerFromJson(Map<String, dynamic> json) =>
    _ConnectedLedger(
      remoteId: json['remoteId'] as String,
      masterKey: PublicKey.fromJson(json['masterKey'] as String),
      deviceModelId: $enumDecode(_$DeviceModelIdEnumMap, json['deviceModelId']),
    );

Map<String, dynamic> _$ConnectedLedgerToJson(_ConnectedLedger instance) =>
    <String, dynamic>{
      'remoteId': instance.remoteId,
      'masterKey': instance.masterKey.toJson(),
      'deviceModelId': _$DeviceModelIdEnumMap[instance.deviceModelId]!,
    };

const _$DeviceModelIdEnumMap = {
  DeviceModelId.blue: 'blue',
  DeviceModelId.nanoS: 'nanoS',
  DeviceModelId.nanoSP: 'nanoSP',
  DeviceModelId.nanoX: 'nanoX',
  DeviceModelId.stax: 'stax',
  DeviceModelId.europa: 'europa',
};
