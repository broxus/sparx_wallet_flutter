import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_view.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template create_seed_page}
/// Starting page for seed creation.
/// {@endtemplate}
class CreateSeedPage
    extends
        InjectedElementaryParametrizedWidget<CreateSeedWidgetModel, String?> {
  /// {@macro create_seed_page}
  const CreateSeedPage({super.key, String? name}) : super(wmFactoryParam: name);

  @override
  Widget build(CreateSeedWidgetModel wm) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const DefaultAppBar(),
      body: DoubleSourceBuilder<SeedPhraseModel?, bool>(
        firstSource: wm.seedState,
        secondSource: wm.copiedState,
        builder: (context, seed, isCopied) {
          final phrase = seed ?? SeedPhraseModel.empty();
          return CreateSeedView(
            seed: phrase,
            isCopied: isCopied ?? false,
            onCopy: wm.copySeed,
            onCheck: wm.onCheck,
            onSkip: wm.onSkip,
          );
        },
      ),
    );
  }
}
