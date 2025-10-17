import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class BiometryConfigurator {
  BiometryConfigurator(this._biometryService);

  final BiometryService _biometryService;
  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('BiometryService initializating...');

    await _biometryService.init();

    _log.finest('BiometryService initialized');
  }
}
