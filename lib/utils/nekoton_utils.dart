import 'package:nekoton_repository/nekoton_repository.dart';

extension NekotonRepositoryUtils on NekotonRepository {
  /// Waits for the completion of all background seed scanning processes.
  ///
  /// When a seed is added to the repository via [addSeed]
  /// with [SeedAddType.import] parameter, one or two background processes
  /// are started:
  /// 1. Scanning for existing wallets (via [triggerAddingAccounts]) (always)
  /// 2. Scanning for derived keys (via [triggerDerivingKeys])
  /// (only for derived key)
  ///
  /// This method returns a [Future] that completes when both of these scanning
  /// processes have finished for the given [masterKey].
  ///
  /// Example:
  /// ```dart
  /// PublicKey publicKey = await nekoton.addSeed(
  ///   phrase: phrase,
  ///   password: password,
  ///   addType: SeedAddType.import,
  /// );
  ///
  /// await nekoton.seedScanCompleter(publicKey);
  /// ```
  Future<void> seedScanCompleter(PublicKey masterKey) => Future.wait([
        findingDerivedKeysStream.firstWhere(
          (keys) => !keys.contains(masterKey.toString()),
        ),
        findingExistingWalletsStream.firstWhere(
          (keys) => !keys.contains(masterKey.toString()),
        ),
      ]);
}
