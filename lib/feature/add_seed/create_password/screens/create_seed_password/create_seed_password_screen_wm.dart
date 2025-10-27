import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen_model.dart';
import 'package:app/feature/biometry/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CreateSeedPasswordWmParams {
  CreateSeedPasswordWmParams({
    required this.phrase,
    required this.mnemonicType,
  });

  final SecureString? phrase;
  final MnemonicType? mnemonicType;
}

/// [WidgetModel] для [CreateSeedPasswordScreen]
@injectable
class CreateSeedPasswordScreenWidgetModel
    extends
        CustomWidgetModelParametrized<
          CreateSeedPasswordScreen,
          CreateSeedPasswordScreenModel,
          CreateSeedPasswordWmParams
        > {
  CreateSeedPasswordScreenWidgetModel(super.model);

  late final passwordController = createTextEditingController();
  late final confirmController = createTextEditingController();

  late final passwordFocus = createFocusNode();
  late final confirmFocus = createFocusNode();

  final formKey = GlobalKey<FormState>();

  late final _loadState = createNotifier<bool>();
  late final _passwordStatusState = createNotifier<PasswordStatus>(
    PasswordStatus.initial,
  );

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<bool> get loadState => _loadState;

  ListenableState<PasswordStatus> get passwordStatusState =>
      _passwordStatusState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    passwordController.addListener(_validate);
    confirmController.addListener(_validate);
  }

  Future<void> onPressedNext() async {
    _loadState.accept(true);

    await model.next(
      context: context,
      password: passwordController.text,
      phrase: wmParams.value.phrase,
      mnemonicType: wmParams.value.mnemonicType,
    );

    if (model.isNeedBiometry) {
      contextSafe?.compassContinue(const EnableBiometryRouteData());
    } else {
      contextSafe?.compassPointNamed(const WalletRouteData());
    }
  }

  void _validate() {
    if (passwordController.text.length < minPasswordLength) {
      _passwordStatusState.accept(PasswordStatus.tooWeak);
    } else {
      if (passwordController.text != confirmController.text) {
        _passwordStatusState.accept(PasswordStatus.mustMatch);
      } else {
        _passwordStatusState.accept(PasswordStatus.match);
      }
    }
  }
}
