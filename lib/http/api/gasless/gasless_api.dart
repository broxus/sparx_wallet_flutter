import 'package:app/http/dto/gasless/gasless_config_dto.dart';
import 'package:app/http/dto/gasless/gasless_estimate_request_dto.dart';
import 'package:app/http/dto/gasless/gasless_estimate_response_dto.dart';
import 'package:app/http/dto/gasless/gasless_send_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'gasless_api.g.dart';

@injectable
@RestApi()
abstract class GaslessApi {
  @factoryMethod
  factory GaslessApi(Dio dio, {String? baseUrl}) = _GaslessApi;

  @GET('/v2/gasless/config')
  Future<GaslessConfigDto> getConfig();

  @POST('/v2/gasless/estimate/{master_id}')
  Future<GaslessEstimateResponseDto> estimate(
    @Path('master_id') String masterId,
    @Body() GaslessEstimateRequestDto body,
  );

  @POST('/v2/gasless/send')
  Future<void> send(
    @Body() GaslessSendRequestDto body,
  );
}
