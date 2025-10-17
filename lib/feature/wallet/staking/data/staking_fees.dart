class StakingFees {
  const StakingFees({
    required this.depositAttachedFee,
    required this.removePendingWithdrawAttachedFee,
    required this.withdrawAttachedFee,
  });

  factory StakingFees.empty() => StakingFees(
    depositAttachedFee: BigInt.zero,
    removePendingWithdrawAttachedFee: BigInt.zero,
    withdrawAttachedFee: BigInt.zero,
  );

  /// Attached fee to call stake method
  final BigInt depositAttachedFee;

  /// Attached fee to call remove pending withdraw method
  final BigInt removePendingWithdrawAttachedFee;

  /// Attached fee to call unstake method
  final BigInt withdrawAttachedFee;
}
