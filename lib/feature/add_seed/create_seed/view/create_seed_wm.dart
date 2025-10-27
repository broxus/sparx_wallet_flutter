import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_model.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class CreateSeedWidgetModel
    extends
        CustomWidgetModelParametrized<
          CreateSeedPage,
          CreateSeedModel,
          String?
        > {
  CreateSeedWidgetModel(super.model);

  late final _seedState = createNotifier<SeedPhraseModel?>();
  late final _copiedState = createNotifier<bool>();

  ListenableState<SeedPhraseModel?> get seedState => _seedState;
  ListenableState<bool> get copiedState => _copiedState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    // Generate initial seed
    _seedState.accept(model.createSeed());
  }

  Future<void> copySeed() async {
    final seed = _seedState.value;
    if (seed == null || seed.isEmpty) return;
    _copiedState.accept(true);
    await Clipboard.setData(ClipboardData(text: seed.phrase));
    Future.delayed(const Duration(seconds: 2), () {
      _copiedState.accept(false);
    });
  }

  Future<void> onCheck(SeedPhraseModel seed) async {
    context.compassContinue(
      CheckSeedPhraseRouteData(
        seedPhrase: await model.encryptSeed(seed.phrase),
        name: wmParams.value,
      ),
    );
  }

  Future<void> onSkip(SeedPhraseModel seed) async {
    context.compassContinue(
      CreateSeedPasswordRouteData(
        seedPhrase: await model.encryptSeed(seed.phrase),
        name: wmParams.value,
        type: SeedAddType.create,
      ),
    );
  }
}
