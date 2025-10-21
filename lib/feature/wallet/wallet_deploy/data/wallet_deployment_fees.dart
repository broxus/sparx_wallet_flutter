/// Contains fee and balance information for wallet deployment
class WalletDeploymentFees {
  const WalletDeploymentFees({required this.fee, required this.balance});

  final BigInt fee;
  final BigInt balance;

  /// Checks if the wallet has sufficient balance for deployment
  bool get hasSufficientBalance => balance >= fee;

  /// Gets the available balance after deployment
  BigInt get availableBalanceAfterDeploy => balance - fee;
}
