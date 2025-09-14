import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class AccountDetailModel extends ElementaryModel {
  AccountDetailModel({
    required ErrorHandler errorHandler,
    required this.nekotonRepository,
    required this.balanceService,
    required this.convertService,
  }) : super(errorHandler: errorHandler);

  final _logger = Logger('AccountDetailModel');

  final NekotonRepository nekotonRepository;
  final BalanceService balanceService;
  final CurrencyConvertService convertService;

  Stream<SeedList> get seedListStream => nekotonRepository.seedListStream;

  SeedList get seedList => nekotonRepository.seedList;

  Transport get currentTransport =>
      nekotonRepository.currentTransport.transport;

  Stream<Money?> accountOverallBalance(Address address) =>
      balanceService.accountOverallBalance(address).map(
            (fixed) => fixed != null ? convertBalance(fixed) : null,
          );

  Money convertBalance(Fixed amount) {
    return convertService.convert(amount);
  }

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) async {
    try {
      return await nekotonRepository.getLocalCustodiansAsync(address);
    } catch (e, t) {
      _logger.severe('getLocalCustodiansAsync', e, t);
      return null;
    }
  }

  Future<TonWallet?> subscribeByAddress(Address address) async {
    try {
      final result = await nekotonRepository.subscribeByAddress(address);
      return result.wallet;
    } catch (e, t) {
      _logger.severe('subscribeByAddress', e, t);
      return null;
    }
  }

  Future<void> unsubscribe(Address address) async {
    try {
      await nekotonRepository.unsubscribe(address);
    } catch (e, t) {
      _logger.severe('unsubscribe', e, t);
    }
  }

  Future<TokenWalletState?> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
  }) async {
    try {
      return await nekotonRepository.subscribeToken(
        owner: owner,
        rootTokenContract: rootTokenContract,
      );
    } catch (e, t) {
      _logger.severe('subscribeToken', e, t);
      return null;
    }
  }

  Future<void> unsubscribeToken(
    Address owner,
    Address rootTokenContract,
  ) async {
    try {
      await nekotonRepository.unsubscribeToken(owner, rootTokenContract);
    } catch (e, t) {
      _logger.severe('unsubscribeToken', e, t);
    }
  }

  bool containsWallet(Address address) {
    return nekotonRepository.walletsMap.containsKey(address);
  }
}
