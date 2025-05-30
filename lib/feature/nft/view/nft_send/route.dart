import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _ownerAddressQueryParam = 'ownerAddress';
const _nftAddressQueryParam = 'nftAddress';
const _collectionAddressQueryParam = 'collectionAddress';
const _publicKeyQueryParam = 'publicKey';
const _destinationQueryParam = 'destination';
const _amountQueryParam = 'amount';

@named
@Singleton(as: CompassBaseRoute)
class NftSendRoute extends CompassRoute<NftSendRouteData> {
  NftSendRoute()
      : super(
          path: '/nft-send',
          builder: (context, data, _) => NftSendWidget(data: data),
        );

  @override
  NftSendRouteData fromQueryParams(Map<String, String> queryParams) {
    return NftSendRouteData(
      owner: Address(address: queryParams[_ownerAddressQueryParam]!),
      address: Address(address: queryParams[_nftAddressQueryParam]!),
      collection: Address(address: queryParams[_collectionAddressQueryParam]!),
      destination: Address(address: queryParams[_destinationQueryParam]!),
      publicKey: PublicKey(publicKey: queryParams[_publicKeyQueryParam]!),
      amount: queryParams[_amountQueryParam]?.let(BigInt.parse),
    );
  }
}

class NftSendRouteData implements CompassRouteDataQuery {
  const NftSendRouteData({
    required this.owner,
    required this.address,
    required this.collection,
    required this.destination,
    required this.publicKey,
    this.amount,
  });

  final Address owner;
  final Address address;
  final Address collection;
  final Address destination;
  final PublicKey publicKey;
  final BigInt? amount;

  @override
  Map<String, String> toQueryParams() {
    return {
      _ownerAddressQueryParam: owner.toRaw(),
      _nftAddressQueryParam: address.toRaw(),
      _collectionAddressQueryParam: collection.toRaw(),
      _destinationQueryParam: destination.toRaw(),
      _publicKeyQueryParam: publicKey.toString(),
      if (amount != null) _amountQueryParam: amount.toString(),
    };
  }
}
