// ignore_for_file: use_build_context_synchronously

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_model.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class SeedDetailPageWidgetModel extends CustomWidgetModelParametrized<
    SeedDetailPageWidget,
    SeedDetailPageModel,
    PublicKey> with BleAvailabilityWmMixin {
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

  Future<void> onAddkeys() async {
    final seed = _seedNotifier.value;
    if (seed == null) return;

    if (seed.masterKey.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;

      contextSafe?.let((context) {
        Navigator.of(context, rootNavigator: true).push(
          deriveKeysSheet(context, wmParams.value),
        );
      });
    } else {
      showDeriveKeysSheetPassword(context, wmParams.value);
    }
  }
}
