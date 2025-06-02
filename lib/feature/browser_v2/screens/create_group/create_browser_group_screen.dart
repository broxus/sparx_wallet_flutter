import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/create_group/widgets/group_title_text_field.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/widgets/browser_tabs_list_Item_body.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CreateBrowserGroupScreen
    extends ElementaryWidget<CreateBrowserGroupScreenWidgetModel> {
  CreateBrowserGroupScreen({
    String? tabId,
    WidgetModelFactory<CreateBrowserGroupScreenWidgetModel>? wmFactory,
    super.key,
  }) : super(
    wmFactory ??
            (ctx) => defaultCreateBrowserGroupScreenWidgetModelFactory(
          ctx,
          tabId: tabId,
        ),
  );

  @override
  Widget build(CreateBrowserGroupScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DimensSizeV2.d12,
            horizontal: DimensSizeV2.d16,
          ),
          child: SizedBox(
            height: wm.screenHeight,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppBarBackButton(onPressed: wm.onPressedBack),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DimensSizeV2.d10,
                              ),
                              child: GroupTitleTextField(
                                onChangeText: wm.onChangeText,
                                onEditingComplete: wm.onEditingComplete,
                                onOverflowLength: wm.onOverflowLength,
                                maxLength: wm.maxLength,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: DimensSizeV2.d48,
                          ),
                        ],
                      ),
                    ),
                    if (wm.tabNotifier != null)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: DimensSizeV2.d28),
                          child: SizedBox(
                            width: DimensSizeV2.d168,
                            height: DimensSizeV2.d200,
                            child: BrowserTabsListItemBody(
                              tabNotifier: wm.tabNotifier!,
                              screenShotState: wm.screenShotState,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: StateNotifierBuilder<bool>(
                    listenableState: wm.errorState,
                    builder: (_, bool? isShowError) {
                      isShowError ??= false;
                      return isShowError
                          ? _Error(
                        LocaleKeys.maxCharactersAllowed.tr(
                          args: [
                            wm.maxLength.toString(),
                          ],
                        ),
                      )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error(
      this.errorText,
      );

  final String errorText;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SizedBox(
      width: double.infinity,
      height: DimensSizeV2.d48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsResV2.e15,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: Row(
            spacing: DimensSizeV2.d12,
            children: [
              const Icon(
                LucideIcons.circleCheck,
                size: DimensSizeV2.d24,
                color: ColorsResV2.e50,
              ),
              Text(
                errorText,
                style: theme.textStyles.labelMedium.copyWith(
                  color: ColorsResV2.e50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}