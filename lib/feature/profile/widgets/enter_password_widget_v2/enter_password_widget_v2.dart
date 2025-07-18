import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/enter_password_widget_v2/enter_password_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// This is a widget that allows user to enter password for any action or
/// user biometry if available.
///
/// Also widget stores/get password from biometry storage.
///
/// This widget can be displayed in any sheet.
///
/// !!! This widget must be an entry point for entering any password, because
/// this widget contains internal logic for checking biometry.
///
/// !!! Widget provides only valid password via [onPasswordEntered].
class EnterPasswordWidgetV2 extends StatefulWidget {
  const EnterPasswordWidgetV2({
    required this.onPasswordEntered,
    required this.publicKey,
    this.title,
    this.isLoading,
    this.isDisabled = false,
    this.isAutofocus = true,
    super.key,
  });

  /// Callback that will be called when user entered password.
  /// Password in this callback always valid.
  final ValueChanged<String> onPasswordEntered;

  /// Key for which password must be entered.
  final PublicKey publicKey;

  final String? title;

  final bool? isLoading;

  final bool isDisabled;

  final bool isAutofocus;

  @override
  State<EnterPasswordWidgetV2> createState() => _EnterPasswordWidgetV2State();
}

class _EnterPasswordWidgetV2State extends State<EnterPasswordWidgetV2> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnterPasswordCubit>(
      create: (_) => EnterPasswordCubit(
        inject<BiometryService>(),
        inject<NekotonRepository>(),
        widget.publicKey,
      )..init(),
      child: BlocConsumer<EnterPasswordCubit, EnterPasswordState>(
        listener: (context, state) {
          if (state case EnterPasswordStateEntered(:final password)) {
            widget.onPasswordEntered(password);
          }
        },
        builder: (context, state) {
          return switch (state) {
            EnterPasswordStateBiometry(:final isFace) => _biometryBody(isFace),
            EnterPasswordStatePassword() => _passwordBody(),
            EnterPasswordStateEntered(
              :final fromBiometry,
              :final isFaceBiometry
            ) =>
              fromBiometry ? _biometryBody(isFaceBiometry) : _passwordBody(),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _biometryBody(bool isFace) => Builder(
        builder: (context) => AccentButton(
          buttonShape: ButtonShape.pill,
          title: widget.title ?? LocaleKeys.submitWord.tr(),
          isLoading: widget.isLoading ?? false,
          icon: isFace ? LucideIcons.scanFace : LucideIcons.fingerprint,
          onPressed: widget.isDisabled
              ? null
              : () => context.read<EnterPasswordCubit>().requestBiometry(
                    isFace: isFace,
                  ),
        ),
      );

  Widget _passwordBody() => Builder(
        builder: (context) => SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            SecureTextField(
              hintText: LocaleKeys.password.tr(),
              textEditingController: _passwordController,
              isAutofocus: widget.isAutofocus && !widget.isDisabled,
              onSubmit: widget.isDisabled
                  ? null
                  : (_) => context
                      .read<EnterPasswordCubit>()
                      .enterPassword(context, _passwordController.text),
            ),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: widget.title ?? LocaleKeys.submitWord.tr(),
              isLoading: widget.isLoading ?? false,
              onPressed: widget.isDisabled
                  ? null
                  : () => context
                      .read<EnterPasswordCubit>()
                      .enterPassword(context, _passwordController.text),
            ),
          ],
        ),
      );
}
