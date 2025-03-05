import 'package:app/data/models/models.dart';
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

/// Mnemonic type for creating seed with 12 words.
/// Used by MyTonWallet etc.
const tonBip39MnemonicType12 = MnemonicType.bip39(
  Bip39MnemonicData(
    accountId: 0,
    path: Bip39Path.ton,
    entropy: Bip39Entropy.bits256,
  ),
);

/// Mnemonic type for creating seed with 24 words.
/// Used by MyTonWallet etc.
const tonBip39MnemonicType24 = MnemonicType.bip39(
  Bip39MnemonicData(
    accountId: 0,
    path: Bip39Path.ton,
    entropy: Bip39Entropy.bits256,
  ),
);

const actualSeedPhraseLength = 12;
const legacySeedPhraseLength = 24;

MnemonicType getMnemonicType({
  required int wordsCount,
  SeedPhraseFormat? format,
}) {
  assert(
    wordsCount == actualSeedPhraseLength ||
        wordsCount == legacySeedPhraseLength,
    'Invalid words count',
  );

  format ??= SeedPhraseFormat.standart;
  return wordsCount == actualSeedPhraseLength
      ? switch (format) {
          SeedPhraseFormat.standart => defaultMnemonicType,
          SeedPhraseFormat.ton => tonBip39MnemonicType12,
        }
      : switch (format) {
          SeedPhraseFormat.standart => const MnemonicType.legacy(),
          SeedPhraseFormat.ton => tonBip39MnemonicType24,
        };
}
