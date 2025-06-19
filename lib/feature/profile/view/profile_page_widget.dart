import 'package:app/feature/profile/view/profile_page_wm.dart';
import 'package:app/feature/profile/view/profile_view.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class ProfilePageWidget extends ElementaryWidget<ProfilePageWidgetModel> {
  const ProfilePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultProfilePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ProfilePageWidgetModel wm) {
    return StateNotifierBuilder<String>(
      listenableState: wm.appVersionState,
      builder: (_, String? appVersion) {
        return ProfileView(
          appVersion: appVersion ?? '',
          isBiometryAvailable: wm.isBiometryAvailable,
          isBiometryEnabled: wm.isBiometryEnabled,
          onManageSeeds: wm.onManageSeeds,
          onExportSeed: wm.onExportSeed,
          onContactSupport: wm.onContactSupport,
          onFAQ: wm.onFAQ,
          onLegal: wm.onLegal,
          onLogout: wm.onLogout,
          onBiomentryChanged: wm.onBiomentryChanged,
          onManageDapps: wm.onManageDapps,
        );
      },
    );
  }
}
