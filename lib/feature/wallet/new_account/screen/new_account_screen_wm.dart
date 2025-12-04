import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

class NewAccountScreenWmParams {
  NewAccountScreenWmParams({required this.publicKey, required this.password});

  final String? publicKey;
  final SecureString? password;
}

/// [WidgetModel] для [NewAccountScreen]
@injectable
class NewAccountScreenWidgetModel
    extends
        CustomWidgetModelParametrized<
          NewAccountScreen,
          NewAccountScreenModel,
          NewAccountScreenWmParams
        > {
  NewAccountScreenWidgetModel(super.model);

  bool get isError => wmParams.value.publicKey == null;

  String? get publicKey => wmParams.value.publicKey;
  SecureString? get password => wmParams.value.password;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  void _init() {
    if (wmParams.value.publicKey == null) {
      model.showError(LocaleKeys.publicKeyNull.tr());
    }
  }
}
