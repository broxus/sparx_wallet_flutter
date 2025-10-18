import 'package:app/utils/parse_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class StakingInformationConverter
    implements JsonConverter<StakingInformation?, Map<String, dynamic>?> {
  const StakingInformationConverter();

  @override
  StakingInformation? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final uri = Uri.tryParse(json['stakingAPYLink'] as String);

    final depFee = parseBigIntOrNull(json['stakeDepositAttachedFee']);
    final remFee =
        parseBigIntOrNull(json['stakeRemovePendingWithdrawAttachedFee']);
    final wdFee = parseBigIntOrNull(json['stakeWithdrawAttachedFee']);

    if (uri == null || depFee == null || remFee == null || wdFee == null) {
      return null;
    }

    return StakingInformation(
      stakingAPYLink: uri,
      stakingRootContractAddress: Address(
        address: json['stakingRootContractAddress'] as String,
      ),
      stakingValutAddress: Address(
        address: json['stakingVaultAddress'] as String,
      ),
      stakeDepositAttachedFee: depFee,
      stakeRemovePendingWithdrawAttachedFee: remFee,
      stakeWithdrawAttachedFee: wdFee,
    );
  }

  @override
  Map<String, dynamic>? toJson(StakingInformation? info) {
    if (info == null) return null;
    return {
      'stakingAPYLink': info.stakingAPYLink.toString(),
      'stakingRootContractAddress': info.stakingRootContractAddress.toString(),
      'stakingVaultAddress': info.stakingValutAddress.toString(),
      'stakeDepositAttachedFee': info.stakeDepositAttachedFee.toString(),
      'stakeRemovePendingWithdrawAttachedFee':
          info.stakeRemovePendingWithdrawAttachedFee.toString(),
      'stakeWithdrawAttachedFee': info.stakeWithdrawAttachedFee.toString(),
    };
  }
}
