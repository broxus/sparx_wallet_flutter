import 'dart:ui';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/view/update_version_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Screen for displaying update version notification
class UpdateVersionScreen
    extends InjectedElementaryWidget<UpdateVersionWidgetModel> {
  const UpdateVersionScreen({
    super.key,
  });

  @override
  Widget build(UpdateVersionWidgetModel wm) {
    return StateNotifierBuilder<UpdateRequest?>(
      listenableState: wm.updateRequestsState,
      builder: (context, request) {
        final targetVersion = request?.targetVersion;
        final noteText = request?.releaseNote?.info;
        final isBlockingUpdate = request?.status == UpdateStatus.blocking;
        final halfImageSize = wm.mediaQuery.size.width / 2;

        return PopCapture(
          onPop: wm.onCancelButtonPressed,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                const SizedBox.expand(
                  child: _BlurredBackground(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Padding(
                        // Add half image empty space for 'fly' effect
                        padding: EdgeInsets.only(top: halfImageSize),
                        child: _UpdateVersionContent(
                          targetVersion: targetVersion,
                          noteText: noteText,
                          isBlockingUpdate: isBlockingUpdate,
                          onUpdate: wm.onUpdateButtonPressed,
                          onCancel: wm.onCancelButtonPressed,
                        ),
                      ),
                      Assets.images.versionUpdateIcon.image(
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UpdateVersionContent extends StatelessWidget {
  const _UpdateVersionContent({
    required this.targetVersion,
    required this.noteText,
    required this.isBlockingUpdate,
    required this.onUpdate,
    required this.onCancel,
  });

  final String? targetVersion;
  final String? noteText;
  final bool isBlockingUpdate;
  final void Function() onUpdate;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(DimensRadiusV2.radius24),
        topRight: Radius.circular(DimensRadiusV2.radius24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            // 80 - content size of icon
            height: DimensSizeV2.d32 + DimensSizeV2.d80,
          ),
          Text(
            LocaleKeys.appNewVersionTitle.tr(),
            style: theme.textStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSizeV2.d4),
          if (targetVersion != null)
            Padding(
              padding: const EdgeInsets.only(bottom: DimensSizeV2.d16),
              child: Text(
                'v$targetVersion',
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.content3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Text(
            noteText ?? LocaleKeys.importantUpdateReleaseNote.tr(),
            style: theme.textStyles.paragraphMedium.copyWith(
              color: theme.colors.content0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DimensSizeV2.d24),
          AccentButton(
            buttonShape: ButtonShape.pill,
            onPressed: onUpdate,
            buttonSize: ButtonSize.medium,
            child: Text(
              LocaleKeys.updateWord.tr(),
              style: theme.textStyles.labelLarge,
              textAlign: TextAlign.center,
            ),
          ),
          if (!isBlockingUpdate)
            Padding(
              padding: const EdgeInsets.only(bottom: DimensSizeV2.d16),
              child: GhostButton(
                buttonShape: ButtonShape.pill,
                onPressed: onCancel,
                buttonSize: ButtonSize.medium,
                child: Text(
                  LocaleKeys.cancelWord.tr(),
                  style: theme.textStyles.labelLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          const SizedBox(height: DimensSizeV2.d16),
        ],
      ),
    );
  }
}

class _BlurredBackground extends StatelessWidget {
  const _BlurredBackground();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 7,
        sigmaY: 7,
      ),
      child: Container(
        color: context.themeStyleV2.colors.backgroundOverlay
            .withValues(alpha: 0.6),
      ),
    );
  }
}
