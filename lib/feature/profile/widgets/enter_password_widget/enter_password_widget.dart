import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/enter_password_widget/enter_password_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

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
class EnterPasswordWidget extends StatefulWidget {
  const EnterPasswordWidget({
    required this.onPasswordEntered,
    required this.publicKey,
    this.buttonText,
    super.key,
  });

  /// Callback that will be called when user entered password.
  /// Password in this callback always valid.
  final ValueChanged<String> onPasswordEntered;

  /// Key for which password must be entered.
  final PublicKey publicKey;
  final String? buttonText;

  @override
  State<EnterPasswordWidget> createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
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

  Widget _biometryBody(bool isFace) {
    return SizedBox(
      height: DimensSize.d100,
      child: Builder(
        builder: (context) {
          return Center(
            child: CommonIconWidget.svg(
              svg: isFace
                  ? Assets.images.faceId.path
                  : Assets.images.finger.path,
              size: DimensSize.d100,
              color: context.themeStyle.colors.textPrimary,
            ),
          );
        },
      ),
    );
  }

  Widget _passwordBody() {
    return Builder(
      builder: (context) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          spacing: DimensSize.d24,
          children: [
            SecureTextField(
              hintText: LocaleKeys.yourPassword.tr(),
              textEditingController: _passwordController,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: widget.buttonText ?? LocaleKeys.submitWord.tr(),
              onPressed: () => context
                  .read<EnterPasswordCubit>()
                  .enterPassword(context, _passwordController.text),
            ),
          ],
        );
      },
    );
  }
}
