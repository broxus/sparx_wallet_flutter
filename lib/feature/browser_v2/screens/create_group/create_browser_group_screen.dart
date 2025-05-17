import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/create_group/widgets/group_title_text_field.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CreateBrowserGroupScreen
    extends ElementaryWidget<CreateBrowserGroupScreenWidgetModel> {
  const CreateBrowserGroupScreen({
    super.key,
    WidgetModelFactory<CreateBrowserGroupScreenWidgetModel> wmFactory =
        defaultCreateBrowserGroupScreenWidgetModelFactory,
  }) : super(
          wmFactory,
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
                    onEditingComplete: wm.onEditingComplete,
                  ),
                ),
              ),
              const SizedBox(
                width: DimensSizeV2.d48,
              )
            ],
          ),
        ),
      ),
    );
  }
}
