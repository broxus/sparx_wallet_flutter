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
class CustodianSettingsWidgetModel extends CustomWidgetModelParametrized<
    CustodiansSettingsView, CustodiansSettingsModel, List<String>> {
  CustodianSettingsWidgetModel(
    super.model,
  );

  late final _custodians = createNotifier<List<CustodianData>>();

  ThemeStyleV2 get theme => context.themeStyleV2;

  ListenableState<List<CustodianData>> get custodians => _custodians;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadCustodians();
  }

  Future<void> _loadCustodians() async {
    final custodians = await model.initializeCustodians(wmParams.value);
    _custodians.accept(custodians);
  }

  Future<void> renameCustodian(PublicKey key) async {
    final newName = await showRenameCustodianModal(context);
    if (newName == null) return;

    await model.rename(key, newName);

    final updatedCustodians = _custodians.value?.map((custodian) {
      if (custodian.key.publicKey == key.publicKey) {
        return CustodianData(name: newName, key: key);
      }
      return custodian;
    }).toList();

    _custodians.accept(updatedCustodians ?? []);

    model.showSuccessfulMessage();
  }
}
