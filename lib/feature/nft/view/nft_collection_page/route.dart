import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show Address;

const String _collectionAddressQueryParam = 'collectionAddress';

@named
@Singleton(as: CompassBaseRoute)
class NftCollectionRoute extends CompassRoute<NftCollectionRouteData> {
  NftCollectionRoute(@Named.from(NftItemRoute) CompassBaseRoute nftItemRoute)
    : super(
        path: '/nft-collection',
        builder: (_, data, __) =>
            NftCollectionPageWidget(collection: data.collection),
        compassBaseRoutes: [nftItemRoute],
      );

  @override
  NftCollectionRouteData fromQueryParams(Map<String, String> queryParams) {
    return NftCollectionRouteData(
      collection: Address(address: queryParams[_collectionAddressQueryParam]!),
    );
  }
}

class NftCollectionRouteData implements CompassRouteDataQuery {
  const NftCollectionRouteData({required this.collection});

  final Address collection;

  @override
  Map<String, String> toQueryParams() => {
    _collectionAddressQueryParam: collection.toRaw(),
  };
}
