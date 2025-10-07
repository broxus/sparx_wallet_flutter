import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_name/route.dart';
import 'package:app/feature/profile/manage_seeds_accounts/view/manage_seeds_accounts_page_model.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class ManageSeedsAccountsPageWidgetModel extends CustomWidgetModel<
    ManageSeedsAccountsPage, ManageSeedsAccountsPageModel> {
  ManageSeedsAccountsPageWidgetModel(super.model);

  late final _currentSeedState =
      createNotifierFromStream(model.currentSeedStream);
  late final _seedsState = createNotifierFromStream(model.seedsStream);

  ListenableState<Seed?> get currentSeedState => _currentSeedState;
  ListenableState<List<Seed>> get seedsState => _seedsState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onAddSeedPhrase() async {
    final selected = await showSelectAddSeedTypeSheet(context);

    if (contextSafe != null && selected != null) {
      switch (selected) {
        case SelectAddSeedType.create:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(command: EnterSeedNameCommand.create),
          );
        case SelectAddSeedType.import:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(command: EnterSeedNameCommand.import),
          );
        case SelectAddSeedType.ledger:
          contextSafe?.compassContinue(
            const EnterSeedNameRouteData(command: EnterSeedNameCommand.ledger),
          );
      }
    }
  }
}
