import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

typedef TokenContractsUpdateCallback = void Function(
  List<TokenContractAsset> contracts,
);

/// [ElementaryModel] for [WalletPrepareTransferPage]
class WalletPrepareTransferPageModel extends ElementaryModel {
  WalletPrepareTransferPageModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._nekotonRepository,
    this._messengerService,
    this._currenciesService,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final CurrenciesService _currenciesService;

  final _balanceDataSc = StreamController<WalletPrepareBalanceData>();

  /// Subscription for list of wallets (Ton/Token)
  StreamSubscription<dynamic>? _walletsSubscription;

  /// Subscription for selected asset (Ton/Token)
  StreamSubscription<dynamic>? _currentWalletSubscription;

  StreamSubscription<dynamic>? _contractSubscription;

  Stream<WalletPrepareBalanceData> get balanceDataStream =>
      _balanceDataSc.stream;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<Map<Address, TonWalletState>> get _walletsStream =>
      _nekotonRepository.walletsMapStream;

  Stream<List<TokenWalletState>> get _tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  final _logger = Logger('WalletPrepareTransferPageModel');

  @override
  void dispose() {
    _closeBalanceSubs();
    _contractSubscription?.cancel();
    _balanceDataSc.close();
    super.dispose();
  }

  Future<int?> getFeeFactor() async {
    final feeFactors = await _nekotonRepository.currentTransport.transport
        .getFeeFactors(isMasterchain: true);
    return feeFactors.gasFeeFactor;
  }

  KeyAccount? findAccountByAddress(Address address) {
    return _nekotonRepository.seedList.findAccountByAddress(address);
  }

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) async {
    try {
      return await _nekotonRepository.getLocalCustodiansAsync(address);
    } on Object catch (e, t) {
      _logger.severe('getLocalCustodiansAsync', e, t);
    }

    return null;
  }

  String? getSeedName(PublicKey custodian) {
    return _nekotonRepository.seedList.findSeedKey(custodian)?.name;
  }

  Future<TokenContractAsset?> getTokenContractAsset(
    Address? rootTokenContract,
  ) async {
    if (rootTokenContract == null) {
      return null;
    }
    return _assetsService.getTokenContractAsset(
      rootTokenContract,
      currentTransport,
    );
  }

  void showError(String text) {
    _messengerService.show(
      Message.error(message: text),
    );
  }

  void startListeningBalance({
    required WalletPrepareTransferAsset? contract,
    required Address address,
  }) {
    _closeBalanceSubs();
    if (contract == null) {
      return;
    }

    if (contract.isNative) {
      _subscribeNativeBalance(contract: contract, address: address);
    } else {
      _subscribeTokenBalance(contract: contract, address: address);
    }
  }

  void findExistedContracts({
    required Address address,
    required TokenContractsUpdateCallback onUpdate,
  }) {
    _contractSubscription =
        _assetsService.contractsForAccount(address).listen((contracts) {
      onUpdate(contracts);

      _contractSubscription?.cancel();
    });
  }

  Future<CustomCurrency?> getCurrencyForContract(
    Address rootTokenContract,
  ) async {
    try {
      return await _currenciesService.getOrFetchCurrency(
        currentTransport,
        rootTokenContract,
      );
    } catch (e, t) {
      _logger.info('getCurrencyForContract($rootTokenContract)', e, t);
      return null;
    }
  }

  Future<Money?> getBalance({
    required WalletPrepareTransferAsset asset,
    required Address address,
  }) async {
    Money? balance;

    if (asset.isNative) {
      final walletState = _nekotonRepository.wallets.firstWhereOrNull(
        (item) => item.address == address,
      );
      balance = walletState?.wallet?.contractState.balance.let(
        (balance) => Money.fromBigIntWithCurrency(
          balance,
          Currencies()[currentTransport.nativeTokenTicker]!,
        ),
      );
    } else {
      final root = asset.rootTokenContract;
      final walletState = _nekotonRepository.tokenWallets.firstWhereOrNull(
        (wallet) => wallet.owner == address && wallet.rootTokenContract == root,
      );

      balance = walletState?.wallet?.moneyBalance;
    }

    return balance;
  }

  /// Subscription for native token to find balance
  void _subscribeNativeBalance({
    required WalletPrepareTransferAsset contract,
    required Address address,
  }) {
    final root = contract.rootTokenContract;
    _walletsSubscription = _walletsStream.listen(
      (wallets) {
        final walletState = wallets[address];

        if (walletState == null) {
          return;
        }

        if (walletState.hasError) {
          final error = walletState.error;
          if (error is Exception) {
            _balanceDataSc.add(WalletPrepareErrorBalanceData(error));
          }

          return;
        }

        final wallet = walletState.wallet;

        if (wallet == null) {
          return;
        }

        _walletsSubscription?.cancel();
        final symbol = currentTransport.nativeTokenTicker;

        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _balanceDataSc.add(
            WalletPrepareNativeBalanceData(
              root: root,
              symbol: symbol,
              balance: wallet.contractState.balance,
            ),
          );
        });
      },
    );
  }

  /// Subscription for token wallet to find balance
  void _subscribeTokenBalance({
    required WalletPrepareTransferAsset contract,
    required Address address,
  }) {
    final root = contract.rootTokenContract;
    final symbol = contract.tokenSymbol;
    _walletsSubscription = _tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == address && w.rootTokenContract == root,
      );

      if (walletState == null) {
        return;
      }

      if (walletState.hasError) {
        final error = walletState.error;
        if (error is Exception) {
          _balanceDataSc.add(WalletPrepareErrorBalanceData(error));
        }

        return;
      }

      final wallet = walletState.wallet;

      if (wallet != null) {
        _walletsSubscription?.cancel();
        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _balanceDataSc.add(
            WalletPrepareTokenBalanceData(
              root: root,
              symbol: symbol,
              money: wallet.moneyBalance,
            ),
          );
        });
      }
    });
  }

  void _closeBalanceSubs() {
    _walletsSubscription?.cancel();
    _currentWalletSubscription?.cancel();
  }
}
