import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';

class NewAccountScreenWmParams {
  NewAccountScreenWmParams({required this.publicKey, required this.password});

  final String? publicKey;
  final String? password;
}

/// [WidgetModel] для [NewAccountScreen]
@injectable
class NewAccountScreenWidgetModel
    extends CustomWidgetModel<NewAccountScreen, NewAccountScreenModel> {
  NewAccountScreenWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final NewAccountScreenWmParams _wmParams;

  bool get isError => _wmParams.publicKey == null;

  String? get publicKey => _wmParams.publicKey;
  String? get password => _wmParams.password;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  void _init() {
    if (_wmParams.publicKey == null) {
      model.showError(context, LocaleKeys.publicKeyNull.tr());
    }
  }
}
