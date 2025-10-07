import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/bottom_sheets/bottom_sheets.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_model.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class WalletAppBarWidgetModel
    extends CustomWidgetModel<WalletAppBarWidget, WalletAppBarModel> {
  WalletAppBarWidgetModel(super.model);

  late final _currentAccountState =
      createNotifierFromStream(model.currentAccount);
  late final _walletState = createNotifierFromStream(model.walletState);
  late final _connectionState =
      createNotifierFromStream(model.connectionStream);

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  ListenableState<TonWalletState?> get walletState => _walletState;

  ListenableState<ConnectionData?> get connectionState => _connectionState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String getWalletTypeName(WalletType walletType) =>
      model.transport.defaultAccountName(walletType);

  void onNetwork() {
    showSelectNetworkSheet(context: context);
  }

  void onSettings() {
    if (currentAccountState.value == null) return;
    showAccountSettingsModal(
      context: context,
      account: currentAccountState.value!,
    );
  }

  void onSelectAccount() => showSelectAccountSheet(context);

  Future<void> onScanQr() async {
    final result = await showQrScanner(context);

    if (!context.mounted || result == null) return;

    return switch (result) {
      QrScanResultAddress(:final value) => _handleAddress(value),
      QrScanResultUri(:final value) => _handleUri(value),
    };
  }

  void _handleAddress(Address address) {
    final account = currentAccountState.value;
    if (account == null) return;

    context.compassContinue(
      WalletPrepareTransferRouteData(
        address: account.address,
        destination: address,
      ),
    );
  }

  void _handleUri(Uri uri) => model.handleUri(uri);
}
