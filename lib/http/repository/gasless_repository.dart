import 'package:app/app/service/connection/connection.dart';
import 'package:app/data/models/models.dart';
import 'package:app/http/http.dart';
import 'package:app/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class GaslessRepository {
  GaslessRepository(
    this._nekotonRepository,
    this._dio,
  );

  final _log = Logger('GaslessRepository');
  final NekotonRepository _nekotonRepository;
  final Dio _dio;
  GaslessApi? _api;

  void init() {
    _nekotonRepository.currentTransportStream
        .whereType<CommonTransportStrategy>()
        .map((transport) => transport.gaslessApiBaseUrl)
        .distinct()
        .listen(
          (baseUrl) => _api = baseUrl?.let(
            (baseUrl) => GaslessApi(_dio, baseUrl: baseUrl),
          ),
        );
  }

  Future<GaslessConfig?> getConfig() async {
    if (_api == null) return null;

    try {
      final response = await _api!.getConfig();

      return GaslessConfig(
        relayAddress: response.relayAddress,
        gasJettons: response.gasJettons
            .map((jetton) => GasJetton(masterId: jetton.masterId))
            .toList(),
      );
    } catch (e, st) {
      _log.severe('Failed to get gasless config', e, st);
      return null;
    }
  }

  Future<GaslessEstimateResponseDto> estimate({
    required String masterId,
    required Address walletAddress,
    required PublicKey walletPublicKey,
    required List<String> messages,
  }) async {
    if (_api == null) throw Exception('API client was not initialized');

    try {
      return await _api!.estimate(
        masterId,
        GaslessEstimateRequestDto(
          walletAddress: walletAddress,
          walletPublicKey: walletPublicKey,
          messages: messages.map((boc) => MessageDto(boc: boc)).toList(),
        ),
      );
    } catch (e, st) {
      _log.severe('Failed to estimate gasless request', e, st);
      rethrow;
    }
  }

  Future<GaslessSendResponseDto> send({
    required PublicKey walletPublicKey,
    required String boc,
  }) async {
    if (_api == null) throw Exception('API client was not initialized');

    try {
      return await _api!.send(
        GaslessSendRequestDto(
          walletPublicKey: walletPublicKey,
          boc: boc,
        ),
      );
    } catch (e, st) {
      _log.severe('Failed to send gasless request', e, st);
      rethrow;
    }
  }
}
