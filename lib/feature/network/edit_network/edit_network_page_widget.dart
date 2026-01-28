import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/feature/network/edit_network/layouts/edit_network_page_widget_default_layout.dart';
import 'package:app/feature/network/edit_network/layouts/edit_network_page_widget_small_layout.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class EditNetworkPageWidget
    extends
        InjectedElementaryParametrizedWidget<EditNetworkWidgetModel, String?> {
  const EditNetworkPageWidget({String? connectionDataId, super.key})
    : super(wmFactoryParam: connectionDataId);

  @override
  Widget build(EditNetworkWidgetModel wm) {
    return isSmallScreenHeight
        ? EditNetworkPageWidgetSmallLayout(wm)
        : EditNetworkPageWidgetDefaultLayout(wm);
  }
}
