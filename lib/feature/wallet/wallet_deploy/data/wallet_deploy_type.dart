/// Wallet deployment type enumeration
enum WalletDeployType {
  /// Standard wallet deployment (single owner)
  standard,
  
  /// Multisig wallet deployment (multiple owners)
  multisig,
}

/// Default number of required confirmations for multisig wallets
const defaultRequireConfirmations = 3;

/// Default number of hours for confirmation timeout
const defaultHoursConfirmations = 24;