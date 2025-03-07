import 'package:nekoton_repository/nekoton_repository.dart';

/// Default mnemonic type for creating seed.
/// Means 12 words.
const defaultMnemonicType = MnemonicType.bip39(
  Bip39MnemonicData(
    accountId: 0,
    path: Bip39Path.ever,
    entropy: Bip39Entropy.bits128,
  ),
);
