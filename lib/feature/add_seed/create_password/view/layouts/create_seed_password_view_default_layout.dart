import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/widgets/password_info_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/default_app_bar.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';
import 'package:ui_components_lib/v2/widgets/text/primary_text.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/secure_text_field.dart';

class CreateSeedPasswordViewDefaultLayout extends StatelessWidget {
  const CreateSeedPasswordViewDefaultLayout({
    required this.scrollController,
    required this.passwordController,
    required this.confirmController,
    required this.pwd1focusNode,
    required this.pwd2focusNode,
    required this.isLoading,
    required this.passwordStatus,
    required this.onPwd1Submit,
    required this.onPwd2Submit,
    required this.onSubmit,
    this.backgroundColor,
    super.key,
  });

  final ScrollController scrollController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final FocusNode pwd1focusNode;
  final FocusNode pwd2focusNode;
  final bool isLoading;
  final PasswordStatus? passwordStatus;
  final Color? backgroundColor;
  final void Function(String? _) onPwd1Submit;
  final void Function(String? _) onPwd2Submit;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const DefaultAppBar(),
      backgroundColor: backgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: DimensSize.d16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.confirmPasswordTitle.tr(),
                        style: themeStyle.textStyles.headingLarge,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: DimensSize.d8),
                      PrimaryText(
                        LocaleKeys.confirmPasswordSubtitle.tr(),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: DimensSize.d24),
                      SecureTextField(
                        focusNode: pwd1focusNode,
                        hintText: LocaleKeys.confirmSetPasswordHint.tr(),
                        textEditingController: passwordController,
                        textInputAction: TextInputAction.next,
                        isAutofocus: true,
                        isEnabled: !isLoading,
                        onSubmit: onPwd1Submit,
                      ),
                      const SizedBox(height: DimensSize.d8),
                      SecureTextField(
                        focusNode: pwd2focusNode,
                        hintText: LocaleKeys.confirmRepeatPasswordHint.tr(),
                        textEditingController: confirmController,
                        textInputAction: TextInputAction.done,
                        isEnabled: !isLoading,
                        onSubmit: onPwd2Submit,
                      ),
                      const SizedBox(height: DimensSize.d24),
                      PasswordInfoSection(
                        themeStyle: themeStyle,
                        status: passwordStatus ?? PasswordStatus.initial,
                      ),
                      const SizedBox(height: DimensSize.d12),
                    ],
                  ),
                ),
              ),
              AccentButton(
                title: LocaleKeys.continueWord.tr(),
                onPressed: passwordStatus == PasswordStatus.match
                    ? onSubmit
                    : null,
                isLoading: isLoading,
                buttonShape: ButtonShape.pill,
              ),
              const SizedBox(height: DimensSize.d24),
            ],
          ),
        ),
      ),
    );
  }
}
