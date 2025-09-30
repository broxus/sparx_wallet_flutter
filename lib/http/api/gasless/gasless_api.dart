import 'package:app/http/dto/gasless/gasless.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'gasless_api.g.dart';

@injectable
@RestApi()
abstract class GaslessApi {
  @factoryMethod
  factory GaslessApi(Dio dio, {String? baseUrl}) = _GaslessApi;

  @GET('/config')
  Future<GaslessConfigDto> getConfig();

  @POST('/estimate/{master_id}')
  Future<GaslessEstimateResponseDto> estimate(
    @Path('master_id') String masterId,
    @Body() GaslessEstimateRequestDto body,
  );

  @POST('/send')
  Future<GaslessSendResponseDto> send(
    @Body() GaslessSendRequestDto body,
  );
}
