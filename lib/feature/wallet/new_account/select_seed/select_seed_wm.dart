import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_model.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

@injectable
class SelectSeedWidgetModel
    extends CustomWidgetModel<SelectSeedWidget, SelectSeedModel>
    with BleAvailabilityWmMixin {
  SelectSeedWidgetModel(super.model);

  late final _currentAccountState = createNotifierFromStream(
    model.currentAccount,
  );
  late final _listState = createNotifierFromStream(model.seedWithAccounts);

  ListenableState<List<Seed>> get listState => _listState;

  ListenableState<Seed?> get currentAccountState => _currentAccountState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  bool hasCurrentAccount(Seed seed) {
    return model.getCurrentKey() == seed.publicKey;
  }

  void selectSeed(Seed seed) {
    _currentAccountState.accept(seed);
  }

  Future<void> onSelect() async {
    final seed = _currentAccountState.value;

    if (contextSafe == null || seed == null) {
      return;
    }

    if (seed.masterKey.isLegacy) {
      contextSafe?.compassContinue(
        NewAccountRouteData(publicKey: seed.publicKey.publicKey),
      );
      return;
    }

    if (seed.masterKey.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;

      contextSafe?.compassContinue(
        NewAccountRouteData(publicKey: seed.publicKey.publicKey),
      );
      return;
    }

    final result = await showAddAccountConfirmSheet(
      context: contextSafe!,
      publicKey: seed.publicKey,
      seedName: seed.name,
    );

    if (contextSafe != null && result != null) {
      contextSafe?.compassContinue(
        NewAccountRouteData(
          publicKey: result.$1.publicKey,
          password: await model.encryptSeed(result.$2),
        ),
      );
    }
  }
}
