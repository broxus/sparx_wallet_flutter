import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/profile/seed_detail/view/seed_detail_page_model.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

SeedDetailPageWidgetModel defaultSeedDetailPageWidgetModelFactory(
  BuildContext context,
) =>
    SeedDetailPageWidgetModel(
      SeedDetailPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class SeedDetailPageWidgetModel
    extends CustomWidgetModel<SeedDetailPageWidget, SeedDetailPageModel>
    with BleAvailabilityMixin {
  SeedDetailPageWidgetModel(super.model);

  late final _currentKey = createNotifierFromStream(model.currentKey);
  late final _currentSeed = createNotifierFromStream(model.currentSeed);
  late final _findingExistingWallets = createNotifierFromStream(
    model.findingExistingWallets,
  );
  late final _seed = createNotifierFromStream(
    model.getSeedStream(widget.publicKey),
  );

  StateNotifier<PublicKey?> get currentKey => _currentKey;

  StateNotifier<Seed?> get currentSeed => _currentSeed;

  StateNotifier<Set<String>> get findingExistingWallets =>
      _findingExistingWallets;

  StateNotifier<Seed?> get seed => _seed;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onSeedSettings() => showSeedSettingsSheet(context, widget.publicKey);

  Future<void> onAddkeys() async {
    final seed = _seed.value;
    if (seed == null) return;

    if (seed.masterKey.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;

      contextSafe?.let((context) {
        Navigator.of(context, rootNavigator: true).push(
          deriveKeysSheet(context, widget.publicKey),
        );
      });
    } else {
      showDeriveKeysSheetPassword(context, widget.publicKey);
    }
  }
}
