import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/domain/nft_service.dart';
import 'package:app/feature/ton_connect/domain/ton_connect_http_bridge.dart';
import 'package:app/feature/update_version/update_version.dart';
import 'package:app/feature/wallet/staking/domain/staking_service.dart';
import 'package:app/http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class FeatureServicesConfigurator {
  FeatureServicesConfigurator(
    this._updateService,
    this._currentSeedService,
    this._currentAccountsService,
    this._currenciesService,
    this._assetsService,
    this._permissionsService,
    this._stakingService,
    this._tokenWalletsService,
    this._tonConnectHttpBridge,
    this._tokenRepository,
    this._nftService,
  );

  final UpdateService _updateService;
  final CurrentSeedService _currentSeedService;
  final CurrentAccountsService _currentAccountsService;
  final CurrenciesService _currenciesService;
  final AssetsService _assetsService;
  final PermissionsService _permissionsService;
  final StakingService _stakingService;
  final TokenWalletsService _tokenWalletsService;
  final TonConnectHttpBridge _tonConnectHttpBridge;
  final TokenRepository _tokenRepository;
  final NftService _nftService;

  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('UpdateService initializing...');

    _updateService.init();
    _log
      ..finest('UpdateService initialized')
      ..finest('CurrentSeedService initializating...');

    await _currentSeedService.init();
    _log
      ..finest('CurrentSeedService initialized')
      ..finest('CurrentAccountsService initializating...');

    await _currentAccountsService.init();
    _log
      ..finest('CurrentAccountsService initialized')
      ..finest('CurrenciesService initializating...');

    _currenciesService.init();
    _log
      ..finest('CurrenciesService initialized')
      ..finest('AssetsService initializating...');

    _assetsService.init();
    _log
      ..finest('AssetsService initialized')
      ..finest('PermissionsService initializing...');

    _permissionsService.init();
    _log
      ..finest('PermissionsService initialized')
      ..finest('StakingService initializing...');

    await _stakingService.init();
    _log
      ..finest('StakingService initialized')
      ..finest('TokenWalletsService initializing...');

    await _tokenWalletsService.init();
    _log
      ..finest('TokenWalletsService initialized')
      ..finest('TonConnectService initializing...');

    await _tonConnectHttpBridge.openSseConnection();
    _log.finest('TonConnectService initialized');

    _tokenRepository.init();
    _log.finest('TokenRepository initialized');

    _nftService.init();
    _log.finest('NftService initialized');
  }
}
