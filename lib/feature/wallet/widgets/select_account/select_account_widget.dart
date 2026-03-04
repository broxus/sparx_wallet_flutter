// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/select_account/layouts/select_account_widget_default_layout.dart';
import 'package:app/feature/wallet/widgets/select_account/layouts/select_account_widget_small_layout.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_wm.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class SelectAccountWidget
    extends InjectedElementaryWidget<SelectAccountWidgetModel> {
  const SelectAccountWidget({required this.scrollController, super.key});

  final ScrollController scrollController;

  @override
  Widget build(SelectAccountWidgetModel wm) {
    return isSmallScreenHeight
        ? SelectAccountWidgetSmallLayout(wm, scrollController: scrollController)
        : SelectAccountWidgetDefaultLayout(
            wm,
            scrollController: scrollController,
          );
  }
}
