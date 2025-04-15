import 'package:nekoton_repository/nekoton_repository.dart';

extension NekotonRepositoryUtils on NekotonRepository {
  Future<void> getSeedScanFuture(PublicKey masterKey) => Future.wait([
        findingDerivedKeysStream.firstWhere(
          (keys) => !keys.contains(masterKey.toString()),
        ),
        findingExistingWalletsStream.firstWhere(
          (keys) => !keys.contains(masterKey.toString()),
        ),
      ]);
}
