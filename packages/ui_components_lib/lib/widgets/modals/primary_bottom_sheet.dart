import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<T?> showPrimaryBottomSheet<T>({
  required BuildContext context,
  String? assetsPath,
  Color? barrierColor,
  String? title,
  String? subtitle,
  Widget? content,
  Widget? firstButton,
  Widget? secondButton,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: DimensSize.d16),
  bool expand = false,
  bool dismissible = true,
  bool wrapIntoAnimatedSize = true,
  bool useRootNavigator = true,
  bool showBackButton = false,
  double bottomSpaceSize = DimensSize.d20,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
    createSmoothModalSheetRoute<T>(
      label: title,
      barrierColor: barrierColor,
      expand: expand,
      dismissible: dismissible,
      wrapIntoAnimatedSize: wrapIntoAnimatedSize,
      builder: (_) => _ContentBottomSheet(
        padding: padding,
        subtitle: subtitle,
        content: content,
        title: title,
        assetsPath: assetsPath,
        firstButton: firstButton,
        secondButton: secondButton,
        showBackButton: showBackButton,
        bottomSpaceSize: bottomSpaceSize,
      ),
    ),
  );
}

class _ContentBottomSheet extends StatelessWidget {
  const _ContentBottomSheet({
    required this.padding,
    required this.showBackButton,
    this.assetsPath,
    this.title,
    this.subtitle,
    this.content,
    this.firstButton,
    this.secondButton,
    this.bottomSpaceSize = DimensSize.d32,
  });

  final String? assetsPath;
  final String? title;
  final String? subtitle;
  final Widget? content;
  final EdgeInsets padding;
  final Widget? firstButton;
  final Widget? secondButton;
  final bool showBackButton;
  final double bottomSpaceSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;
    return Material(
      color: theme.colors.background1,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: DimensSize.d4),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: PrimaryScrollController.maybeOf(context),
                child: Container(
                  decoration: BoxDecoration(color: theme.colors.background1),
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: DimensSize.d34),
                      if (showBackButton)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: DimensSize.d12,
                              bottom: DimensSize.d40,
                            ),
                            child: FloatButton(
                              buttonShape: ButtonShape.circle,
                              icon: LucideIcons.arrowLeft,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      if (assetsPath != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSize.d16,
                          ),
                          child: Image.asset(
                            assetsPath!,
                            width: DimensSize.d56,
                            height: DimensSize.d56,
                          ),
                        ),
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: DimensSize.d8),
                          child: Semantics(
                            container: true,
                            header: true,
                            child: Text(
                              title!,
                              style: theme.textStyles.headingLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSize.d24,
                          ),
                          child: Text(
                            subtitle!,
                            style: theme.textStyles.paragraphMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (content != null) content!,
                      if (firstButton != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSize.d12,
                          ),
                          child: firstButton,
                        ),
                      if (secondButton != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSize.d12,
                          ),
                          child: secondButton,
                        ),
                      SizedBox(height: bottomSpaceSize),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: DimensSize.d6),
                    width: DimensSize.d40,
                    height: DimensSize.d4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensSize.d100),
                      color: theme.colors.backgroundInput,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
