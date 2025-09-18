import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/widgets/enter_password/data/data.dart';
import 'package:app/feature/profile/widgets/enter_password/enter_password_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

typedef GetLedgerAuthInput = FutureOr<SignInputAuthLedger> Function();

/// This is a widget that allows user to enter password for any action or
/// user biometry if available.
///
/// Also widget stores/get password from biometry storage.
///
/// This widget can be displayed in any sheet.
///
/// !!! This widget must be an entry point for entering any password, because
/// this widget contains internal logic for checking biometry.
class EnterPasswordWidget extends InjectedElementaryParametrizedWidget<
    EnterPasswordWidgetModel, EnterPasswordWmParams> {
  EnterPasswordWidget({
    required PublicKey publicKey,
    required ValueChanged<String> onPasswordEntered,
    String? title,
    bool isLoading = false,
    bool isDisabled = false,
    bool isAutofocus = true,
    super.key,
  }) : super(
          wmFactoryParam: EnterPasswordWmParams(
            publicKey: publicKey,
            title: title,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isAutofocus: isAutofocus,
            getLedgerAuthInput: null,
            onConfirmed: null,
            onPasswordEntered: onPasswordEntered,
          ),
        );

  EnterPasswordWidget.auth({
    required PublicKey publicKey,
    required ValueChanged<SignInputAuth> onConfirmed,
    GetLedgerAuthInput? getLedgerAuthInput,
    String? title,
    bool isLoading = false,
    bool isDisabled = false,
    bool isAutofocus = true,
    super.key,
  }) : super(
          wmFactoryParam: EnterPasswordWmParams(
            publicKey: publicKey,
            title: title,
            isLoading: isLoading,
            isDisabled: isDisabled,
            isAutofocus: isAutofocus,
            getLedgerAuthInput: getLedgerAuthInput,
            onConfirmed: onConfirmed,
            onPasswordEntered: null,
          ),
        );

  @override
  Widget build(EnterPasswordWidgetModel wm) {
    return DoubleValueListenableBuilder(
      firstValue: wm.enterPasswordState,
      secondValue: wm.props,
      builder: (_, state, props) {
        if (state == null) {
          return const SizedBox.shrink();
        }

        return switch (state) {
          EnterPasswordStateBiometry(:final isFace) => _Biometry(
              title: props.title,
              isDisabled: props.isDisabled,
              isLoading: props.isLoading,
              isFace: isFace,
              onSubmit: wm.onBiometry,
            ),
          EnterPasswordStatePassword() => _Password(
              title: props.title,
              isDisabled: props.isDisabled,
              isAutofocus: props.isAutofocus,
              isLoading: props.isLoading,
              controller: wm.passwordController,
              onSubmit: wm.onPassword,
            ),
          EnterPasswordStateLedger() => _Ledger(
              title: props.title,
              isDisabled: props.isDisabled,
              isLoading: props.isLoading,
              onSubmit: wm.onLedger,
            ),
        };
      },
    );
  }
}

class _Ledger extends StatelessWidget {
  const _Ledger({
    required this.title,
    required this.isDisabled,
    required this.isLoading,
    required this.onSubmit,
  });

  final String? title;
  final bool isDisabled;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AccentButton(
      buttonShape: ButtonShape.pill,
      title: title ?? LocaleKeys.submitOnLedger.tr(),
      isLoading: isLoading,
      icon: LucideIcons.bluetooth,
      onPressed: isDisabled ? null : onSubmit,
    );
  }
}

class _Biometry extends StatelessWidget {
  const _Biometry({
    required this.title,
    required this.isDisabled,
    required this.isLoading,
    required this.isFace,
    required this.onSubmit,
  });

  final String? title;
  final bool isDisabled;
  final bool isLoading;
  final bool isFace;
  final ValueChanged<bool> onSubmit;

  @override
  Widget build(BuildContext context) {
    return AccentButton(
      buttonShape: ButtonShape.pill,
      title: title ?? LocaleKeys.submitWord.tr(),
      isLoading: isLoading,
      icon: isFace ? LucideIcons.scanFace : LucideIcons.fingerprint,
      onPressed: isDisabled ? null : () => onSubmit(isFace),
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    required this.title,
    required this.isDisabled,
    required this.isAutofocus,
    required this.isLoading,
    required this.controller,
    required this.onSubmit,
  });

  final String? title;
  final bool isDisabled;
  final bool isAutofocus;
  final bool isLoading;
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        SecureTextField(
          hintText: LocaleKeys.password.tr(),
          textEditingController: controller,
          isAutofocus: isAutofocus && !isDisabled,
          onSubmit: isDisabled ? null : (_) => onSubmit(controller.text),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: title ?? LocaleKeys.submitWord.tr(),
          isLoading: isLoading,
          onPressed: isDisabled ? null : () => onSubmit(controller.text),
        ),
      ],
    );
  }
}
