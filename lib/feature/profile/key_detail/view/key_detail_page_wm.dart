import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/view/key_detail_page_model.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class KeyDetailPageWidgetModel extends CustomWidgetModelParametrized<
    KeyDetailPage, KeyDetailPageModel, PublicKey> {
  KeyDetailPageWidgetModel(super.model);

  late final _accountsTab = createNotifier(KeyDetailAccountsTab.local);
  late final _data = createNotifier<KeyDetailData>();

  StreamSubscription<Seed?>? _seedSub;

  StateNotifier<KeyDetailAccountsTab> get accountsTab => _accountsTab;

  StateNotifier<KeyDetailData?> get data => _data;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _seedSub = model.seedStreamForKey(wmParams.value).listen(
      _onSeedChanged,
      onError: (Object e, StackTrace s) {
        // Elementary's ErrorHandler is already wired in the model; here we
        // just ignore and rely on UI to stay stable.
      },
    );
  }

  @override
  void dispose() {
    _seedSub?.cancel();
    super.dispose();
  }

  void _onSeedChanged(Seed? seed) {
    final key = seed?.findKeyByPublicKey(wmParams.value);
    if (seed == null || key == null) {
      // If key no longer exists, close the page like previous Cubit behavior
      context.compassBack();
      return;
    }

    _data.accept(KeyDetailData(key: key, ownerSeedName: seed.name));
  }

  void changeTab(KeyDetailAccountsTab tab) => _accountsTab.accept(tab);

  void showKeySettings() {
    final current = _data.value;
    if (current == null) return;

    showKeySettingsSheet(
      context: context,
      publicKey: current.key.publicKey,
      isMaster: current.key.isMaster,
    );
  }
}

class KeyDetailData {
  KeyDetailData({
    required this.key,
    required this.ownerSeedName,
  });

  final SeedKey key;
  final String ownerSeedName;
}
