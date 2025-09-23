// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_default_account_names.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletDefaultAccountNames _$WalletDefaultAccountNamesFromJson(
        Map<String, dynamic> json) =>
    _WalletDefaultAccountNames(
      multisig: json['multisig'] == null
          ? defaultMultisigNames
          : const MultisigTypeConverter()
              .fromJson(json['multisig'] as Map<String, dynamic>?),
      walletV3: json['walletV3'] as String? ?? 'WalletV3',
      highloadWalletV2:
          json['highloadWalletV2'] as String? ?? 'Highload WalletV2',
      everWallet: json['everWallet'] as String? ?? 'Ever Wallet',
      walletV3R1: json['walletV3R1'] as String? ?? 'WalletV3R1',
      walletV3R2: json['walletV3R2'] as String? ?? 'WalletV3R2',
      walletV4R1: json['walletV4R1'] as String? ?? 'WalletV4R1',
      walletV4R2: json['walletV4R2'] as String? ?? 'WalletV4R2',
      walletV5R1: json['walletV5R1'] as String? ?? 'WalletV5R1',
    );

Map<String, dynamic> _$WalletDefaultAccountNamesToJson(
        _WalletDefaultAccountNames instance) =>
    <String, dynamic>{
      'multisig': const MultisigTypeConverter().toJson(instance.multisig),
      'walletV3': instance.walletV3,
      'highloadWalletV2': instance.highloadWalletV2,
      'everWallet': instance.everWallet,
      'walletV3R1': instance.walletV3R1,
      'walletV3R2': instance.walletV3R2,
      'walletV4R1': instance.walletV4R1,
      'walletV4R2': instance.walletV4R2,
      'walletV5R1': instance.walletV5R1,
    };
