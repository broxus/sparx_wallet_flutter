// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_page.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_profile_model.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_sheet.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CreateSeedPasswordProfileWmParams {
  const CreateSeedPasswordProfileWmParams({
    required this.seedPhrase,
    required this.name,
    required this.type,
    required this.mnemonicType,
    required this.isChecked,
  });

  final SeedPhraseModel seedPhrase;
  final bool isChecked;
  final String? name;
  final SeedAddType type;
  final MnemonicType? mnemonicType;
}

@injectable
class CreateSeedPasswordProfileWidgetModel
    extends CustomWidgetModelParametrized<CreateSeedPasswordProfilePage,
        CreateSeedPasswordProfileModel, CreateSeedPasswordProfileWmParams> {
  CreateSeedPasswordProfileWidgetModel(super.model);

  late final passwordController = createTextEditingController();
  late final confirmController = createTextEditingController();

  late final _loadingState = createNotifier(false);
  late final _passwordStatusState = createNotifier(PasswordStatus.initial);

  ListenableState<bool> get loadingState => _loadingState;
  ListenableState<PasswordStatus> get passwordStatusState =>
      _passwordStatusState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    passwordController.addListener(_validate);
    confirmController.addListener(_validate);
  }

  Future<void> onPressedNext() async {
    if (_loadingState.value ?? false) return;
    _loadingState.accept(true);

    final params = wmParams.value;
    final publicKey = await model.addSeed(
      context: context,
      seedPhrase: params.seedPhrase,
      name: params.name,
      password: passwordController.text,
      type: params.type,
      mnemonicType: params.mnemonicType,
      isChecked: params.isChecked,
    );

    if (publicKey == null) {
      _loadingState.accept(false);
      return;
    }

    final routeData = await showSwitchToSeedSheet(
      context: context,
      publicKey: publicKey,
    );
    try {
      contextSafe
        ?..compassPointNamed(const ProfileRouteData())
        ..compassPointNamed(
          routeData ?? const ManageSeedsAccountsRouteData(),
        );
      // contextSafe?.compassPointNamed(
      //   routeData ?? const ManageSeedsAccountsRouteData(),
      // );
    } catch (_) {}
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
