import 'package:app/app/service/connection/connection_service.dart';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class ConnectionConfigurator {
  ConnectionConfigurator(this._connectionService, this._nekotonRepository);

  final ConnectionService _connectionService;
  final NekotonRepository _nekotonRepository;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('ConnectionService initializating...');

    // TODO(nesquikm): Theoretically, this should be called every time after app

    await _connectionService.setUp();

    _log.finest('NekotonRepository start SeedList listening');

    _nekotonRepository
      ..setupSeedListUpdating()
      ..setupWalletsSubscriptions();
    _log.finest('ConnectionService initialized');
  }
}
