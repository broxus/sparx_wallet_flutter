// ignore_for_file: one_member_abstracts

import 'package:app/http/dto/ton_token_info/ton_token_info_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ton_api.g.dart';

@RestApi()
abstract class TonApi {
  factory TonApi(Dio dio, {String? baseUrl}) = _TonApi;

  @GET('/token/{address}')
  Future<TonTokenInfoDto> getTokenInfo(@Path('address') String address);
}
