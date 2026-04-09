import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/create_seed/view/create_seed_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/seed_view_layout.dart';
import 'package:flutter/material.dart';

/// {@template create_seed_page}
/// Starting page for seed creation.
/// {@endtemplate}
class CreateSeedScreen
    extends
        InjectedElementaryParametrizedWidget<CreateSeedWidgetModel, String?> {
  /// {@macro create_seed_page}
  const CreateSeedScreen({super.key, String? name})
    : super(wmFactoryParam: name);

  @override
  Widget build(CreateSeedWidgetModel wm) {
    return SeedViewLayout(
      title: LocaleKeys.saveSeedPhrase.tr(),
      description: LocaleKeys.saveSeedWarning.tr(),
      wordsState: wm.wordsState,
      onPressSkip: wm.onSkip,
      onPressCopy: wm.copySeed,
      onPressCheck: wm.onCheck,
    );
  }
}
