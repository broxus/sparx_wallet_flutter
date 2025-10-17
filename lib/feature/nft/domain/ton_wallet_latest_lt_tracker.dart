import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TonWalletLatestLtTracker implements LatestLtTracker {
  TonWalletLatestLtTracker({
    required this.address,
    required this.networkGroup,
    required this.nftStorageService,
  });

  final Address address;
  final NetworkGroup networkGroup;
  final NftStorageService nftStorageService;

  @override
  BigInt? get latestLt => nftStorageService.readLatestLt(
    address: address,
    networkGroup: networkGroup,
  );

  @override
  void updateLatestLt(BigInt maxLt) {
    nftStorageService.writeLatestLt(
      address: address,
      networkGroup: networkGroup,
      lt: maxLt,
    );
  }
}
