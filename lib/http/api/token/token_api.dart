import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'token_api.g.dart';

@RestApi()
abstract class TokenApi {
  factory TokenApi(Dio dio, {String? baseUrl}) = _TokenApi;

  @POST('/balances')
  Future<GetTokenBalancesResponseDto> getBalances(
    @Body() GetTokenBalancesRequestDto params,
  );

  @POST('/balances/search')
  Future<SearchTokenBalancesResponseDto> searchBalances(
    @Body() SearchTokenBalancesRequestDto params,
  );
}
