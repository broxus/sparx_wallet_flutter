import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/choose_network/route.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// [WidgetModel] для [WelcomeScreen]
@injectable
class WelcomeScreenWidgetModel
    extends CustomWidgetModel<WelcomeScreen, WelcomeScreenModel> {
  WelcomeScreenWidgetModel(super.model);

  final _decentralizationPolicyLink = 'https://l1.broxus.com/sparx/terms/';

  late final _isBackupAvailableState = createNotifier<bool>(false);

  ThemeStyle get themeStyle => context.themeStyle;

  ListenableState<bool> get isBackupAvailableState => _isBackupAvailableState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _checkBackupAvailability();
  }

  void onPressedCreateWallet() {
    model.saveUserNew(userWithNewWallet: true);
    contextSafe?.compassContinue(
      const ChooseNetworkRouteData(
        nextStep: ChooseNetworkNextStep.createSeedPassword,
      ),
    );
  }

  void onPressedWalletLogin() {
    model.saveUserNew(userWithNewWallet: false);
    contextSafe?.compassContinue(
      const ChooseNetworkRouteData(
        nextStep: ChooseNetworkNextStep.addExistingWallet,
      ),
    );
  }

  void onPressedRestoreBackup() {
    model.saveUserNew(userWithNewWallet: false);
    contextSafe?.compassContinue(
      const ChooseNetworkRouteData(
        nextStep: ChooseNetworkNextStep.restoreBackup,
      ),
    );
  }

  void onLinkTap() => launchUrlString(_decentralizationPolicyLink);

  void onChangeLanguage() => showLocalizationSheet(context: context);

  void onClickSupport() => showContactSupportSheet(
    context: context,
    mode: ContactSupportMode.initiatedByUser,
  );

  Future<void> _checkBackupAvailability() async {
    if (!model.isBackupEnabled) return;

    final isAvailable = await model.isBackupAvailable();
    _isBackupAvailableState.accept(isAvailable);
  }
}
