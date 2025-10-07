import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:app/feature/biometry/view/biometry_screen_model.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class BiometryScreenWidgetModel
    extends CustomWidgetModel<BiometryScreen, BiometryScreenModel> {
  BiometryScreenWidgetModel(super.model);

  late final _isFaceBiometryState = createNotifier<bool>();

  StateNotifier<bool> get isFaceBiometryState => _isFaceBiometryState;
  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    _isFaceBiometryState.accept(await model.checkFaceBiometry());
  }

  Future<void> onEnableBiometry() async {
    await model.enableBiometry(LocaleKeys.biometryAuthReason.tr());
    _openWallet();
  }

  void onSkip() => _openWallet();

  void onSystemPop() => _openWallet();

  void _openWallet() => contextSafe?.compassPoint(const WalletRouteData());
}
