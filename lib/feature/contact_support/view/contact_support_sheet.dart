import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/bottom_space.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [ContactSupportSheet].
Future<void> showContactSupportSheet({
  required BuildContext context,
  required ContactSupportMode mode,
}) {
  final title = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportBottomSheetHeaderInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportBottomSheetHeaderInitiatedByCrash.tr(),
  };

  final subtitle = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportBottomSheetTextInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportBottomSheetTextInitiatedByCrash.tr(),
  };

  return showCommonBottomSheet(
    context: context,
    title: title,
    subtitle: subtitle,
    centerTitle: true,
    centerSubtitle: true,
    body: (_, __) => ContactSupportSheet(mode: mode),
  );
}

class ContactSupportSheet
    extends
        InjectedElementaryParametrizedWidget<
          ContactSupportWidgetModel,
          ContactSupportMode
        > {
  const ContactSupportSheet({required ContactSupportMode mode, super.key})
    : super(wmFactoryParam: mode);

  @override
  Widget build(ContactSupportWidgetModel wm) {
    final buttonText = switch (wm.mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByCrash.tr(),
    };

    return StateNotifierBuilder(
      listenableState: wm.busyState,
      builder: (_, isBusy) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: buttonText,
            isLoading: isBusy ?? false,
            onPressed: wm.onSendEmail,
          ),
          if (wm.isQaEnabled) const SizedBox(height: DimensSizeV2.d16),
          if (wm.isQaEnabled)
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.contactSupportOpenQa.tr(),
              onPressed: wm.onOpenQa,
            ),
          const BottomSpace(),
        ],
      ),
    );
  }
}
