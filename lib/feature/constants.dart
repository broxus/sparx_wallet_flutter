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

/// Mnemonic type for creating seed with 24 words.
/// Used by MyTonWallet etc.
const tonBip39MnemonicType = MnemonicType.bip39(
  Bip39MnemonicData(
    accountId: 0,
    path: Bip39Path.ton,
    entropy: Bip39Entropy.bits256,
  ),
);

const actualSeedPhraseLength = 12;
const legacySeedPhraseLength = 24;
