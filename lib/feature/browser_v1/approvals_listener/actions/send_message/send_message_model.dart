import 'package:app/feature/ledger/ledger.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SendMessageModel extends ElementaryModel with BleAvailabilityModelMixin {
  SendMessageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Stream<Money> getBalanceStream(Address address) => _nekotonRepository
      .walletsMapStream
      .map((wallets) => wallets[address])
      .mapNotNull((wallet) => wallet?.wallet?.contractState.balance)
      .map(
        (value) => Money.fromBigIntWithCurrency(
          value,
          Currencies()[transport.nativeTokenTicker]!,
        ),
      );

  Future<TonWalletState> getTonWalletState(Address address) async {
    final wallet = await _nekotonRepository.walletsMapStream
        .mapNotNull((wallets) => wallets[address])
        .first;
    return wallet;
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) =>
      _nekotonRepository.getLocalCustodiansAsync(address);

  Future<UnsignedMessage> prepareTransfer({
    required Address address,
    required Address destination,
    required PublicKey? publicKey,
    required BigInt amount,
    required FunctionCall? payload,
    required bool bounce,
  }) async {
    final body = await payload?.let(
      (value) => encodeInternalInput(
        contractAbi: payload.abi,
        method: payload.method,
        input: payload.params,
      ),
    );

    return _nekotonRepository.prepareTransfer(
      address: address,
      publicKey: publicKey,
      expiration: defaultSendTimeout,
      params: [
        TonWalletTransferParams(
          destination: destination,
          amount: amount,
          body: body,
          bounce: defaultMessageBounce,
        ),
      ],
    );
  }

  Future<BigInt> estimateFees({
    required Address address,
    required UnsignedMessage message,
  }) => _nekotonRepository.estimateFees(address: address, message: message);

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree({
    required Address address,
    required UnsignedMessage message,
    List<IgnoreTransactionTreeSimulationError>? ignoredComputePhaseCodes,
    List<IgnoreTransactionTreeSimulationError>? ignoredActionPhaseCodes,
  }) => _nekotonRepository.simulateTransactionTree(
    address: address,
    message: message,
    ignoredComputePhaseCodes: ignoredComputePhaseCodes,
    ignoredActionPhaseCodes: ignoredActionPhaseCodes,
  );

  String? getSeedName(PublicKey custodian) =>
      _nekotonRepository.seedList.findSeedKey(custodian)?.name;

  Future<(Address, RootTokenContractDetails)>
  getTokenRootDetailsFromTokenWallet(Address address) async {
    final details = await TokenWallet.getTokenRootDetailsFromTokenWallet(
      address: address,
      transport: transport.transport,
    );

    return details;
  }

  Future<SignInputAuthLedger> getLedgerAuthInput({
    required Address address,
    required PublicKey custodian,
    required Currency currency,
  }) async {
    final walletState = await getTonWalletState(address);

    return SignInputAuthLedger(
      wallet: walletState.wallet!.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.transfer(
          wallet: walletState.wallet!,
          asset: currency.symbol,
          decimals: currency.decimalDigits,
          custodian: custodian,
        ),
      ),
    );
  }
}
