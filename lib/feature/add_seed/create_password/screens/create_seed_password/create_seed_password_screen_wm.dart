import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/navigation_wm_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [CreateSeedPasswordScreenWidgetModel]
CreateSeedPasswordScreenWidgetModel
    defaultCreateSeedPasswordScreenWidgetModelFactory(
  BuildContext context,
) =>
        CreateSeedPasswordScreenWidgetModel(
          CreateSeedPasswordScreenModel(
            createPrimaryErrorHandler(context),
            inject(),
            inject(),
            inject(),
            inject(),
            inject(),
          ),
        );

/// [WidgetModel] для [CreateSeedPasswordScreen]
class CreateSeedPasswordScreenWidgetModel extends CustomWidgetModel<
    CreateSeedPasswordScreen,
    CreateSeedPasswordScreenModel> with NavigationMixin {
  CreateSeedPasswordScreenWidgetModel(
    super.model,
  );

  late final passwordController = createTextEditingController();
  late final confirmController = createTextEditingController();

  late final passwordFocus = createFocusNode();
  late final confirmFocus = createFocusNode();

  final formKey = GlobalKey<FormState>();

  late final _loadState = createNotifier<bool>();
  late final _passwordStatusState =
      createNotifier<PasswordStatus>(PasswordStatus.initial);

  final _minPasswordLength = 8;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<bool> get loadState => _loadState;

  ListenableState<PasswordStatus> get passwordStatusState =>
      _passwordStatusState;

  @override
  void initWidgetModel() {
    passwordController.addListener(_validate);
    confirmController.addListener(_validate);
    super.initWidgetModel();
  }

  void pop() {
    goPop(
      removeQueries: [
        addSeedPhraseQueryParam,
      ],
    );
  }

  Future<void> onPressedNext() async {
    _loadState.accept(true);

    await model.next(
      context: context,
      password: passwordController.text,
      phrase: widget.phrase,
      mnemonicType: widget.mnemonicType,
    );

    if (model.isNeedBiometry) {
      contextSafe?.goFurther(AppRoute.enableBiometry.path);
    } else {
      contextSafe?.goNamed(AppRoute.wallet.name);
    }
  }

  void _validate() {
    if (passwordController.text.length < _minPasswordLength) {
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
