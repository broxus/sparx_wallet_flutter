import 'package:app/app/service/service.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class ConnectionConfigurator {
  ConnectionConfigurator(
    this._connectionService,
    this._nekotonRepository,
    this._dio,
  );

  final ConnectionService _connectionService;
  final NekotonRepository _nekotonRepository;
  final Dio _dio;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('ConnectionService initializating...');

    await _connectionService.setUp();

    _log.finest('NekotonRepository start SeedList listening');

    _nekotonRepository
      ..setupSeedListUpdating()
      ..setupWalletsSubscriptions(dio: _dio);
    _log.finest('ConnectionService initialized');
  }
}
