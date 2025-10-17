import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class NtpConfigurator {
  NtpConfigurator(this._ntpService);

  final NtpService _ntpService;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('NtpService initializating...');

    await _ntpService.init();

    _log.finest('NtpService initialized');
  }
}
