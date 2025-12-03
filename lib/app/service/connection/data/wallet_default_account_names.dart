import 'package:app/app/service/connection/json_converters/multisig_type_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'wallet_default_account_names.freezed.dart';

part 'wallet_default_account_names.g.dart';

@freezed
abstract class WalletDefaultAccountNames with _$WalletDefaultAccountNames {
  factory WalletDefaultAccountNames({
    @MultisigTypeConverter()
    @Default(defaultMultisigNames)
    Map<MultisigType, String> multisig,
    @Default('WalletV3') String walletV3,
    @Default('Highload WalletV2') String highloadWalletV2,
    @Default('Ever Wallet') String everWallet,
    @Default('WalletV3R1') String walletV3R1,
    @Default('WalletV3R2') String walletV3R2,
    @Default('WalletV4R1') String walletV4R1,
    @Default('WalletV4R2') String walletV4R2,
    @Default('WalletV5R1') String walletV5R1,
  }) = _WalletDefaultAccountNames;

  factory WalletDefaultAccountNames.fromJson(Map<String, dynamic> json) =>
      _$WalletDefaultAccountNamesFromJson(json);
}
