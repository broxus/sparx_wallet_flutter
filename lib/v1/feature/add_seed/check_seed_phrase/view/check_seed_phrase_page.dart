import 'package:app/app/router/router.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_phrase_page}
/// Entry point to check if user wrote down seed phrase correctly.
/// {@endtemplate}
class CheckSeedPhrasePage extends StatelessWidget {
  /// {@macro check_seed_phrase_page}
  const CheckSeedPhrasePage({
    required this.seed,
    this.name,
    super.key,
  });

  final String? name;
  final SeedPhraseModel seed;

  void _navigateToPassword(
    BuildContext context,
    SeedPhraseModel seed,
  ) {
    context.compassContinue(
      CreateSeedPasswordRouteData(
        seedPhrase: seed.phrase,
        name: name,
        type: SeedAddType.create,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckSeedPhraseCubit>(
      create: (context) => CheckSeedPhraseCubit(
        seed,
        (SeedPhraseModel seed) => _navigateToPassword(context, seed),
      )..initAnswers(),
      child: Scaffold(
        appBar: DefaultAppBar(
          onClosePressed: (context) => context.compassBack(),
          actions: [
            CommonButton.ghost(
              padding: EdgeInsets.zero,
              text: LocaleKeys.skipWord.tr(),
              onPressed: () => _navigateToPassword(context, seed),
            ),
          ],
        ),
        body: const CheckSeedPhraseView(),
      ),
    );
  }
}
