import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/route.dart';
import 'package:app/v1/feature/add_seed/create_seed/route.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/view/enter_seed_name_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Commands that will be used to choose where to navigate after entering name
enum EnterSeedNameCommand {
  import,
  create;

  static EnterSeedNameCommand getByName(String? name) {
    if (name == null || EnterSeedNameCommand.values.asNameMap()[name] == null) {
      return create;
    }

    return EnterSeedNameCommand.values.asNameMap()[name]!;
  }
}

/// {@template enter_seed_name_create_page}
/// Page that allows user to enter seed name, used only in profile section as
/// a STARTING screen in seed CREATING or IMPORTING flows.
/// {@endtemplate}
class EnterSeedNamePage extends StatelessWidget {
  /// {@macro enter_seed_name_create_page}
  const EnterSeedNamePage({
    required this.command,
    super.key,
  });

  final EnterSeedNameCommand command;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const DefaultAppBar(),
        body: EnterSeedNameView(
          // ignore: prefer-extracting-callbacks
          callback: (name) {
            switch (command) {
              case EnterSeedNameCommand.import:
                context.compassContinue(
                  EnterSeedPhraseRouteData(
                    isOnboarding: false,
                    seedName: name,
                  ),
                );
              case EnterSeedNameCommand.create:
                context.compassContinue(
                  CreateSeedRouteData(
                    seedName: name,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
