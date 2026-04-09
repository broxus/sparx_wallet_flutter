import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_model.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_screen.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class CreateSeedWidgetModel
    extends
        CustomWidgetModelParametrized<
          CreateSeedScreen,
          CreateSeedModel,
          String?
        > {
  CreateSeedWidgetModel(super.model);

  late final _wordsState = createNotNullNotifier<List<String>>([]);

  ListenableState<List<String>> get wordsState => _wordsState;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _wordsState.accept(model.createSeed());
  }

  Future<void> copySeed() async {
    final phrase = _wordsState.value.join(' ');

    if (phrase.isEmpty) {
      return;
    }

    await setClipBoardData(phrase, isSensitive: true);
    model.showMessageAboutCopy();
  }

  Future<void> onCheck() async {
    final phrase = _wordsState.value;

    if (phrase.isEmpty) {
      return;
    }

    context.compassContinue(
      CheckSeedPhraseRouteData(
        seedPhrase: await model.encryptSeed(phrase.join(' ')),
        name: wmParams.value,
      ),
    );
  }

  Future<void> onSkip() async {
    final phrase = _wordsState.value.join(' ');

    if (phrase.isEmpty) {
      return;
    }

    context.compassContinue(
      CreateSeedPasswordRouteData(
        seedPhrase: await model.encryptSeed(phrase),
        name: wmParams.value,
        type: SeedAddType.create,
      ),
    );
  }
}
