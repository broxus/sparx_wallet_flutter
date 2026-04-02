import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _ownerAddressQueryParam = 'ownerAddress';
const _nftAddressQueryParam = 'nftAddress';
const _collectionAddressQueryParam = 'collectionAddress';
const _tokenFlagQueryParam = 'tokenFlag';
const _destinationQueryParam = 'destination';

@named
@Singleton(as: CompassBaseRoute)
class NftPrepareTransferRoute
    extends CompassRoute<NftPrepareTransferRouteData> {
  NftPrepareTransferRoute(
    @Named.from(NftSendRoute) CompassBaseRoute nftSendRoute,
  ) : super(
        path: '/nft-prepare-transfer',
        builder: (_, data, __) {
          return NftPrepareTransfer(routeData: data);
        },
        compassBaseRoutes: [nftSendRoute],
      );

  @override
  NftPrepareTransferRouteData fromQueryParams(Map<String, String> queryParams) {
    final ownerAddress = queryParams.require(_ownerAddressQueryParam);
    final nftAddress = queryParams.require(_nftAddressQueryParam);
    final collectionAddress = queryParams.require(_collectionAddressQueryParam);
    final tokenFlag = queryParams.require(_tokenFlagQueryParam);

    return NftPrepareTransferRouteData(
      owner: Address(address: ownerAddress),
      address: Address(address: nftAddress),
      collection: Address(address: collectionAddress),
      tokenFlag: bool.parse(tokenFlag),
      destination: queryParams[_destinationQueryParam]?.let(
        (address) => Address(address: address),
      ),
    );
  }
}

class NftPrepareTransferRouteData implements CompassRouteDataQuery {
  const NftPrepareTransferRouteData({
    required this.owner,
    required this.address,
    required this.collection,
    this.destination,
    this.tokenFlag = false,
  });

  final Address owner;
  final Address address;
  final Address collection;
  final bool tokenFlag;
  final Address? destination;

  @override
  Map<String, String> toQueryParams() {
    final destination = this.destination;

    return {
      _ownerAddressQueryParam: owner.toRaw(),
      _nftAddressQueryParam: address.toRaw(),
      _collectionAddressQueryParam: collection.toRaw(),
      _tokenFlagQueryParam: tokenFlag.toString(),
      if (destination != null) _destinationQueryParam: destination.toRaw(),
    };
  }
}
