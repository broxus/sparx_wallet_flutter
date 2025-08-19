// ignore_for_file: use_build_context_synchronously

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/seed_settings_sheet.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_model.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_widget.dart';
import 'package:app/feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_sheet_password.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class SeedDetailPageWidgetModel extends CustomWidgetModelParametrized<
    SeedDetailPageWidget, SeedDetailPageModel, PublicKey> {
  SeedDetailPageWidgetModel(
    super.model,
  );

  late final _currentKeyNotifier = createNotifierFromStream(model.currentKey);
  late final _currentSeedNotifier = createNotifierFromStream(model.currentSeed);
  late final _findingExistingWalletsNotifier = createNotifierFromStream(
    model.findingExistingWallets,
  );
  late final _seedNotifier = createNotifierFromStream(
    model.getSeedStream(wmParams.value),
  );

  StateNotifier<PublicKey?> get currentKeyNotifier => _currentKeyNotifier;

  StateNotifier<Seed?> get currentSeedNotifier => _currentSeedNotifier;

  StateNotifier<Set<String>> get findingExistingWalletsNotifier =>
      _findingExistingWalletsNotifier;

  StateNotifier<Seed?> get seedNotifier => _seedNotifier;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onSeedSettings() => showSeedSettingsSheet(context, wmParams.value);

  void onAddkeys() => showDeriveKeysSheetPassword(context, wmParams.value);
}
