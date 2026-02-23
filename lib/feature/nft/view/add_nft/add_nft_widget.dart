import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_wm.dart';
import 'package:app/feature/nft/view/add_nft/layouts/add_nft_default_layout.dart';
import 'package:app/feature/nft/view/add_nft/layouts/add_nft_small_layout.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class AddNftWidget extends InjectedElementaryWidget<AddNftWidgetModel> {
  const AddNftWidget({super.key});

  @override
  Widget build(AddNftWidgetModel wm) {
    return isSmallScreenHeight
        ? AddNftSmallLayout(wm)
        : AddNftDefaultLayout(wm);
  }
}
