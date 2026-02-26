import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/http/api/ton/ton_api.dart';
import 'package:app/http/dto/ton_token_info/ton_token_info_dto.dart';
import 'package:app/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class TonRepository {
  TonRepository(this._nekotonRepository, this._dio);

  final NekotonRepository _nekotonRepository;
  final Dio _dio;
  TonApi? _api;
  StreamSubscription<String?>? _subscription;

  void init() {
    _subscription?.cancel();
    _subscription = _nekotonRepository.currentTransportStream
        .whereType<CommonTransportStrategy>()
        .map((transport) => transport.tonTokensApiBaseUrl)
        .distinct()
        .listen((baseUrl) {
          _api = baseUrl?.let((baseUrl) => TonApi(_dio, baseUrl: baseUrl));
        });
  }

  @disposeMethod
  void dispose() {
    _api = null;
    _subscription?.cancel();
    _subscription = null;
  }

  Future<TonTokenInfoDto> getTokenInfo({required Address address}) async {
    final api = _api;
    if (api == null) {
      throw Exception(
        'TonRepository: API client not initialized. Ensure init() is called '
        'and transport is properly configured before calling getTokenInfo().',
      );
    }

    return api.getTokenInfo(address.toString());
  }
}
