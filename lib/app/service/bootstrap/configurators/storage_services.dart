import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class StorageConfigurator {
  StorageConfigurator(this._storageManagerService);

  final StorageManagerService _storageManagerService;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('StorageManagerService initializating...');

    await _storageManagerService.init();

    _log.finest('StorageManagerService initialized');
  }
}
