import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_model.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_view.dart';
import 'package:app/feature/wallet/custodians_settings/rename_custodian_modal.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class CustodianSettingsWidgetModel
    extends
        CustomWidgetModelParametrized<
          CustodiansSettingsView,
          CustodiansSettingsModel,
          Address
        > {
  CustodianSettingsWidgetModel(super.model);

  late final _custodiansState = createNotifier<List<CustodianData>>();
  late final _requiredState = createNotifier<int>();

  ThemeStyleV2 get theme => context.themeStyleV2;

  ListenableState<List<CustodianData>> get custodiansState => _custodiansState;

  ListenableState<int> get requiredState => _requiredState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    final walletState = await model.getWallet(wmParams.value);
    final wallet = walletState.wallet;
    if (wallet == null) return;

    final custodians = model.getCustodiansForAccount(wallet);
    _custodiansState.accept(custodians);
    _requiredState.accept(wallet.details.requiredConfirmations);
  }

  Future<void> renameCustodian(PublicKey key) async {
    final newName = await showRenameCustodianModal(context);
    if (newName == null) return;

    await model.rename(key, newName);

    final updatedCustodians = _custodiansState.value?.map((custodian) {
      if (custodian.key.publicKey == key.publicKey) {
        return CustodianData(name: newName, key: key);
      }
      return custodian;
    }).toList();

    _custodiansState.accept(updatedCustodians ?? []);

    model.showSuccessfulMessage();
  }
}
