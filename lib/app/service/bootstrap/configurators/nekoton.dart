import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class NekotonConfigurator {
  NekotonConfigurator(
    this._nekotonRepository,
    this._nekotonStorageService,
    this._tonWalletStorageService,
    this._tokenWalletStorageService,
    this._ntpService,
  );

  static const _minSubscriptionsAtTime = 15;

  final NekotonRepository _nekotonRepository;
  final NekotonStorageService _nekotonStorageService;
  final TonWalletStorageService _tonWalletStorageService;
  final TokenWalletStorageService _tokenWalletStorageService;
  final NtpService _ntpService;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('NekotonRepository initializating...');

    _nekotonRepository
      ..tonSubscribeAtTimeAmount = _minSubscriptionsAtTime
      ..tokenSubscribeAtTimeAmount = _minSubscriptionsAtTime;

    await _nekotonRepository.setupNekotonAndStorage(
      storage: _nekotonStorageService,
      tonWalletStorage: _tonWalletStorageService,
      tokenWalletStorage: _tokenWalletStorageService,
    );

    _ntpService.offsetStream.listen(_nekotonRepository.updateClockOffset);

    _log.finest('NekotonRepository initialized with storage!');
  }
}
