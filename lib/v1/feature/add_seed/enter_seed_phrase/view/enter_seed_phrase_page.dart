import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/v1/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template enter_seed_phrase_page}
/// Starting page for seed phrase entering.
/// {@endtemplate}
@Deprecated('Use v2 version')
class EnterSeedPhrasePage extends StatelessWidget {
  /// {@macro enter_seed_phrase_page}
  const EnterSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnterSeedPhraseCubit>(
      create: (context) => EnterSeedPhraseCubit(
        // ignore: prefer-extracting-callbacks
        (phrase) {
          final path =
              GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
          final route = getCurrentAppRoute(fullPath: path);

          // because of automatic navigation, we may face problem with double
          // navigation here.
          if (route != AppRoute.createSeedPassword) {
            context.goFurther(
              AppRoute.createSeedPassword.pathWithData(
                queryParameters: {addSeedPhraseQueryParam: jsonEncode(phrase)},
              ),
              preserveQueryParams: true,
            );
          }
        },
      )..init(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: DefaultAppBar(),
          body: EnterSeedPhraseView(),
        ),
      ),
    );
  }
}
