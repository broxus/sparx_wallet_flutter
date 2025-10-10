import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deployment_fees.dart';
import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletDeployConfirmModel extends ElementaryModel {
  WalletDeployConfirmModel(
    ErrorHandler errorHandler,
    this._walletDeploymentService,
  ) : super(errorHandler: errorHandler);

  final WalletDeploymentService _walletDeploymentService;

  TransportStrategy get currentTransport =>
      _walletDeploymentService.currentTransport;

  Future<WalletDeploymentFees> loadFees({
    required Address address,
    required WalletDeployType deployType,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    int? hours,
  }) async {
    // Calculate fees and load balance using deployment parameters
    final fee = await _walletDeploymentService.calculateDeploymentFees(
      address: address,
      deployType: deployType,
      custodians: custodians,
      requireConfirmations: requireConfirmations,
      hours: hours,
    );

    final balance = await _walletDeploymentService.getWalletBalance(address);

    return WalletDeploymentFees(fee: fee, balance: balance);
  }

  Future<CustomCurrency?> getOrFetchNativeCurrency() {
    return _walletDeploymentService.getOrFetchNativeCurrency();
  }

  Future<TonWalletState> getWallet(Address address) {
    return _walletDeploymentService.getWallet(address);
  }

  SignInputAuthLedger? getLedgerAuthInput(TonWallet wallet) {
    return _walletDeploymentService.getLedgerAuthInput(wallet);
  }

  KeyAccount? getAccountByAddress(Address address) {
    return _walletDeploymentService.getAccountByAddress(address);
  }

  void storeTemporaryAuth(SignInputAuth auth) {
    _walletDeploymentService.storeTemporaryAuth(auth);
  }
}
