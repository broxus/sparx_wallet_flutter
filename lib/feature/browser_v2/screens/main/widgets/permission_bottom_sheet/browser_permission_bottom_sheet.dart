import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/permission_bottom_sheet/browser_permission_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<PermissionResponse?> showBrowserPermissionBottomSheet(
  BuildContext context, {
  required WebUri uri,
  required List<PermissionResourceType> resources,
}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) {
      return SafeArea(
        child: BrowserPermissionBottomSheet(
          uri: uri,
          resources: resources,
        ),
      );
    },
  );
}

class BrowserPermissionBottomSheet extends InjectedElementaryParametrizedWidget<
    BrowserPermissionBottomSheetWidgetModel, BrowserPermissionParam> {
  BrowserPermissionBottomSheet({
    required WebUri uri,
    required List<PermissionResourceType> resources,
    super.key,
  }) : super(
          wmFactoryParam: BrowserPermissionParam(
            uri: uri,
            resources: resources,
          ),
        );

  @override
  Widget build(BrowserPermissionBottomSheetWidgetModel wm) {
    return SizedBox(
      width: double.infinity,
      height: DimensSizeV2.d300,
      child: PrimaryBottomSheetContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
          child: Column(
            children: [
              Text(
                LocaleKeys.browserRequestPermissionTitle.tr(),
                style: wm.textStyles.headingLarge,
              ),
              const SizedBox(height: DimensSizeV2.d24),
              StateNotifierBuilder(
                listenableState: wm.permissionsState,
                builder: (_, String? value) {
                  if (value == null) {
                    return const SizedBox.shrink();
                  }

                  return Text(
                    LocaleKeys.browserRequestPermissionDescription.tr(
                      args: [value, wm.host],
                    ),
                    style: wm.textStyles.paragraphLarge,
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const SizedBox(height: DimensSizeV2.d24),
              AccentButton(
                buttonShape: ButtonShape.pill,
                onPressed: wm.onPressedAllow,
                title: LocaleKeys.allowWord.tr(),
              ),
              const SizedBox(height: DimensSizeV2.d8),
              DestructiveButton(
                buttonShape: ButtonShape.pill,
                onPressed: wm.onPressedCancel,
                title: LocaleKeys.cancelWord.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
