import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/view/key_detail_page_wm.dart';
import 'package:app/feature/profile/key_detail/view/view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point for screen with information about key
class KeyDetailPage
    extends
        InjectedElementaryParametrizedWidget<
          KeyDetailPageWidgetModel,
          PublicKey
        > {
  const KeyDetailPage({required PublicKey publicKey, super.key})
    : super(wmFactoryParam: publicKey);

  @override
  Widget build(KeyDetailPageWidgetModel wm) {
    return DoubleSourceBuilder(
      firstSource: wm.dataState,
      secondSource: wm.accountsTabState,
      builder: (_, data, tab) {
        final hasData = data != null && tab != null;

        return Scaffold(
          appBar: DefaultAppBar(
            actions: !hasData
                ? null
                : [
                    FloatButton(
                      buttonShape: ButtonShape.circle,
                      icon: LucideIcons.cog,
                      buttonSize: ButtonSize.medium,
                      onPressed: wm.showKeySettings,
                    ),
                  ],
          ),
          body: !hasData
              ? const SizedBox.shrink()
              : SafeArea(
                  minimum: const EdgeInsets.only(bottom: DimensSize.d16),
                  child: KeyDetailView(
                    seedKey: data.key,
                    seedName: data.ownerSeedName,
                    tab: tab,
                    onTabChanged: wm.changeTab,
                  ),
                ),
        );
      },
    );
  }
}
