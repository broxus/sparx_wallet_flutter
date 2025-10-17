import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class AccountTransactionsTabModel extends ElementaryModel {
  AccountTransactionsTabModel(
    ErrorHandler errorHandler,
    this._walletStorage,
    this._nekotonRepository,
    this._currenciesService,
  ) : super(errorHandler: errorHandler);

  final TonWalletStorageService _walletStorage;
  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;

  // Streams from repo
  Stream<Map<Address, TonWalletState>> get walletsMapStream =>
      _nekotonRepository.walletsMapStream;

  Stream<TransportStrategy> get currentTransportStream =>
      _nekotonRepository.currentTransportStream;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<List<TransactionWithData<TransactionAdditionalInfo?>>?>
  transactionsStream({
    required int networkId,
    required String group,
    required Address address,
  }) => _walletStorage.transactionsStream(
    networkId: networkId,
    group: group,
    address: address,
  );

  Stream<List<PendingTransactionWithData>?> pendingTransactionsRawStream({
    required int networkId,
    required String group,
    required Address address,
  }) => _walletStorage.pendingTransactionsStream(
    networkId: networkId,
    group: group,
    address: address,
  );

  Stream<List<PendingTransactionWithData>?> expiredTransactionsRawStream({
    required int networkId,
    required String group,
    required Address address,
  }) => _walletStorage.expiredTransactionsStream(
    networkId: networkId,
    group: group,
    address: address,
  );

  List<TonWalletOrdinaryTransaction> mapOrdinaryTransactions({
    required Address walletAddress,
    required List<TransactionWithData<TransactionAdditionalInfo?>> transactions,
  }) => _nekotonRepository.mapOrdinaryTransactions(
    walletAddress: walletAddress,
    transactions: transactions,
  );

  List<TonWalletPendingTransaction> mapPendingTransactions({
    required Address walletAddress,
    required List<PendingTransactionWithData> pendingTransactions,
  }) => _nekotonRepository.mapPendingTransactions(
    walletAddress: walletAddress,
    pendingTransactions: pendingTransactions,
  );

  List<TonWalletExpiredTransaction> mapExpiredTransactions({
    required Address walletAddress,
    required List<PendingTransactionWithData> expiredTransactions,
  }) => _nekotonRepository.mapExpiredTransactions(
    walletAddress: walletAddress,
    expiredTransactions: expiredTransactions,
  );

  Future<List<TonWalletMultisigExpiredTransaction>>
  mapMultisigExpiredTransactions({
    required Address walletAddress,
    required List<TransactionWithData<TransactionAdditionalInfo?>> transactions,
    required List<MultisigPendingTransaction> multisigPendingTransactions,
  }) => _nekotonRepository.mapMultisigExpiredTransactions(
    walletAddress: walletAddress,
    transactions: transactions,
    multisigPendingTransactions: multisigPendingTransactions,
  );

  Future<List<TonWalletMultisigOrdinaryTransaction>>
  mapMultisigOrdinaryTransactions({
    required Address walletAddress,
    required List<TransactionWithData<TransactionAdditionalInfo?>> transactions,
    required List<MultisigPendingTransaction> multisigPendingTransactions,
  }) => _nekotonRepository.mapMultisigOrdinaryTransactions(
    walletAddress: walletAddress,
    transactions: transactions,
    multisigPendingTransactions: multisigPendingTransactions,
  );

  Future<List<TonWalletMultisigPendingTransaction>>
  mapMultisigPendingTransactions({
    required Address walletAddress,
    required List<TransactionWithData<TransactionAdditionalInfo?>> transactions,
    required List<MultisigPendingTransaction> multisigPendingTransactions,
  }) => _nekotonRepository.mapMultisigPendingTransactions(
    walletAddress: walletAddress,
    transactions: transactions,
    multisigPendingTransactions: multisigPendingTransactions,
  );

  Future<void> preloadTransactions({
    required Address address,
    required String fromLt,
  }) =>
      _nekotonRepository.preloadTransactions(address: address, fromLt: fromLt);

  Future<CustomCurrency?> getOrFetchNativeCurrency(
    TransportStrategy transport,
  ) => _currenciesService.getOrFetchNativeCurrency(transport);
}
