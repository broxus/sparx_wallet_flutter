import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/feature/profile/manage_seeds_accounts/route.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/profile/view/profile_page_model.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const _faqUrl = 'https://docs.sparxwallet.com';
const _legalUrl = 'https://l1.broxus.com/sparx/terms';

@injectable
class ProfilePageWidgetModel
    extends CustomWidgetModel<ProfilePageWidget, ProfilePageModel> {
  ProfilePageWidgetModel(super.model);

  late final _seed = createNotifierFromStream(model.currentSeedStream);
  late final _biometryAvailability =
      createNotifierFromStream(model.biometryAvailabilityStream);
  late final _biometryEnabled =
      createNotifierFromStream(model.biometryEnabledStream);
  late final _appVersionState = createNotifier('');

  ListenableState<bool> get isBiometryAvailable => _biometryAvailability;

  ListenableState<bool> get isBiometryEnabled => _biometryEnabled;

  ListenableState<String> get appVersionState => _appVersionState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> onLogout() async {
    final confirmed = await showLogOutConfirmSheet(context);

    if (confirmed && context.mounted) {
      await model.logout();
    }
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> onBiomentryChanged(bool enabled) async {
    await model.setBiometryEnabled(enabled: enabled);
  }

  void onManageSeeds() {
    context.compassContinue(const ManageSeedsAccountsRouteData());
  }

  void onExportSeed() {
    final currentSeed = _seed.value;
    if (currentSeed == null) return;

    Navigator.of(context, rootNavigator: true).push(
      exportSeedSheetRoute(
        context,
        currentSeed.publicKey,
      ),
    );
  }

  void onContactSupport() {
    showContactSupportSheet(
      context: context,
      mode: ContactSupportMode.initiatedByUser,
    );
  }

  void onFAQ() => model.openBrowserUrl(_faqUrl);

  void onLegal() => model.openBrowserUrl(_legalUrl);

  void onManageDapps() => showTCManageDappsSheet(context);

  Future<void> _init() async {
    _appVersionState.accept(await model.appVersion);
  }
}
