import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _nftAddressQueryParam = 'nftAddress';
const _collectionAddressQueryParam = 'collectionAddress';

@named
@Singleton(as: CompassBaseRoute)
class NftItemRoute extends CompassRoute<NftItemRouteData> {
  NftItemRoute(
    @Named.from(NftPrepareTransferRoute)
    CompassBaseRoute nftPrepareTransferRoute,
  ) : super(
          path: '/nft-item',
          builder: (_, data, __) => NftItemPageWidget(
            address: data.address,
            collection: data.collection,
          ),
          compassBaseRoutes: [
            nftPrepareTransferRoute,
          ],
        );

  @override
  NftItemRouteData fromQueryParams(Map<String, String> queryParams) {
    return NftItemRouteData(
      address: Address(address: queryParams[_nftAddressQueryParam]!),
      collection: Address(address: queryParams[_collectionAddressQueryParam]!),
    );
  }
}

class NftItemRouteData implements CompassRouteDataQuery {
  const NftItemRouteData({
    required this.address,
    required this.collection,
  });

  final Address address;
  final Address collection;

  @override
  Map<String, String> toQueryParams() => {
        _nftAddressQueryParam: address.toRaw(),
        _collectionAddressQueryParam: collection.toRaw(),
      };
}
