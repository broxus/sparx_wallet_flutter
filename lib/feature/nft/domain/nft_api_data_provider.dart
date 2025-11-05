import 'package:app/http/http.dart';
import 'package:app/utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class NftApiDataProvider extends NftDataProvider {
  NftApiDataProvider(this._dio);

  final Dio _dio;

  @override
  Future<NftList> getNftList({
    required String apiBaseUrl,
    required Address collection,
    required Address owner,
    required int limit,
    int? offset,
  }) async {
    final nftApi = NftApi(_dio, baseUrl: apiBaseUrl);
    final list = await nftApi.getNftList(
      NftListRequestDto(
        collections: [collection],
        owners: [owner],
        limit: limit,
        offset: offset ?? 0,
        verified: false,
      ),
    );

    return NftList(
      items: list.items
          .map((e) => _mapNftItem(dto: e, collection: collection, owner: owner))
          .toList(),
      continuation: list.items.isNotEmpty
          ? (list.items.length + (offset ?? 0)).toString()
          : null,
    );
  }

  NftItem _mapNftItem({
    required NftItemDto dto,
    required Address collection,
    required Address owner,
  }) {
    return NftItem(
      nft: Nft(
        address: dto.address,
        info: NftInfo(
          collection: collection,
          id: dto.nftId ?? '',
          manager: dto.manager ?? owner,
          owner: owner,
        ),
        json: NftJsonData(
          name: dto.name,
          description: dto.description,
          preview: dto.image?.let(
            (source) => FileMetadata(source: source, mimetype: dto.mimetype),
          ),
          files: [
            ?dto.image?.let(
              (source) => FileMetadata(source: source, mimetype: dto.mimetype),
            ),
            ?dto.fullImage?.let(
              (source) =>
                  FileMetadata(source: source, mimetype: dto.fullImageMimetype),
            ),
          ],
        ),
      ),
    );
  }
}
