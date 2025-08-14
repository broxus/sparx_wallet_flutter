import 'package:app/app/router/router.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/check_seed_phrase/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/add_seed/create_seed/create_seed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template create_seed_page}
/// Starting page for seed creation.
/// {@endtemplate}
class CreateSeedPage extends StatelessWidget {
  /// {@macro create_seed_page}
  const CreateSeedPage({
    super.key,
    this.name,
  });

  final String? name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateSeedCubit>(
      create: (_) => CreateSeedCubit()..init(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(),
        body: CreateSeedView(
          // ignore: prefer-extracting-callbacks
          checkCallback: (SeedPhraseModel seed) {
            context.compassContinue(
              CheckSeedPhraseRouteData(
                seedPhrase: seed.phrase,
                name: name,
              ),
            );
          },
          skipCallback: (seed) {
            context.compassContinue(
              CreateSeedPasswordRouteData(
                seedPhrase: seed.phrase,
                name: name,
                type: SeedAddType.create,
              ),
            );
          },
        ),
      ),
    );
  }
}
