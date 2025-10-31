// ignore_for_file: one_member_abstracts

import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nft_api.g.dart';

@injectable
@RestApi()
abstract class NftApi {
  @factoryMethod
  factory NftApi(Dio dio, {String? baseUrl}) = _NftApi;

  @POST('/nfts')
  Future<NftListResponseDto> getNftList(@Body() NftListRequestDto body);
}
