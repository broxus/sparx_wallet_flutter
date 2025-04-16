import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    body: (_, __) => BlocProvider(
      create: ContactSupportBloc.new,
      child: BlocListener<ContactSupportBloc, ContactSupportState>(
        listener: (context, state) {
          if (!state.isBusy) {
            Navigator.of(context).pop();
          }
        },
        child: ContactSupportSheet(mode: mode),
      ),
    ),
  );
}

class ContactSupportSheet extends StatelessWidget {
  const ContactSupportSheet({
    required this.mode,
    super.key,
  });

  final ContactSupportMode mode;

  @override
  Widget build(BuildContext context) {
    final buttonText = switch (mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByCrash.tr(),
    };

    return BlocBuilder<ContactSupportBloc, ContactSupportState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: DimensSizeV2.d24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: buttonText,
                isLoading: state.isBusy,
                onPressed: () {
                  context
                      .read<ContactSupportBloc>()
                      .add(ContactSupportEvent.sendEmail(mode));
                },
              ),
              if (state.isQaEnabled) const SizedBox(height: DimensSizeV2.d16),
              if (state.isQaEnabled)
                AccentButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.contactSupportOpenQa.tr(),
                  onPressed: () {
                    context
                        .read<ContactSupportBloc>()
                        .add(const ContactSupportEvent.openQaScreen());
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
