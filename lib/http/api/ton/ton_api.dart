import 'package:app/http/dto/ton_token_info/ton_token_info_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'ton_api.g.dart';

@injectable
@RestApi()
// ignore: one_member_abstracts
abstract class TonApi {
  @factoryMethod
  factory TonApi(Dio dio, {String? baseUrl}) = _TonApi;

  @GET('/token/{address}')
  Future<TonTokenInfoDto> getTokenInfo(@Path('address') String address);
}
