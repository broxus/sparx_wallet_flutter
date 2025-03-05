import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/overlay/custom_overlay.dart';
import 'package:ui_components_lib/v2/widgets/popup_menu/app_popup_menu_item.dart';

Future<void> showPopupMenuWithOverlay(
  BuildContext context,
  GlobalKey key,
  List<AppPopupMenuItem> items,
) async {
  final keys = List.generate(items.length, (index) => GlobalKey());
  if (key.currentContext?.findRenderObject() is! RenderBox) {
    return;
  }
  final renderBox = key.currentContext!.findRenderObject()! as RenderBox;
  final offset = renderBox.localToGlobal(Offset.zero);
  Future.delayed(Duration(milliseconds: 300), () {
    CustomOverlay.showOverlay(context, [key, ...keys]);
  });
  showMenu(
    constraints: BoxConstraints(minWidth: renderBox.size.width),
    color: context.themeStyleV2.colors.background2,
    context: context,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height,
      offset.dx,
      offset.dy,
    ),
    items: List.generate(
      items.length,
      (index) => PopupMenuItem(
        key: keys[index],
        child: items[index],
      ),
    ),
  );
}
