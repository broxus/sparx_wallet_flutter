import 'package:app/feature/browser_v2/screens/main/widgets/browser_text_button.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/browser_group_menu_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/groups_menu/widgets/item.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<void> showBrowserTabMenu(
  BuildContext context,
) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withAlpha(204),
    useRootNavigator: true,
    builder: (_) {
      return const BrowserGroupMenu();
    },
  );
}

class BrowserGroupMenu extends ElementaryWidget<BrowserGroupMenuWidgetModel> {
  const BrowserGroupMenu({
    super.key,
    WidgetModelFactory<BrowserGroupMenuWidgetModel> wmFactory =
        defaultBrowserGroupMenuWidgetModelFactory,
  }) : super(
          wmFactory,
        );

  @override
  Widget build(BrowserGroupMenuWidgetModel wm) {
    return SizedBox(
      width: double.infinity,
      height: DimensSizeV2.d348,
      child: PrimaryBottomSheetContainer(
        backgroundColor: ColorsResV2.n15,
        child: Column(
          children: [
            _Header(
              onPressedEdit: wm.onPressedEditAll,
              onPressedDone: wm.onPressedDone,
            ),
            const SizedBox(height: DimensSizeV2.d22),
            _GroupsList(
              groupsState: wm.groupsState,
              activeGroupIdState: wm.activeGroupIdState,
              editGroupsState: wm.editGroupsState,
              onPressedItem: wm.onPressedItem,
              onPressedEditGroup: wm.onPressedEditGroup,
              onPressedRemoveGroup: wm.onPressedRemoveGroup,
            ),
            const SizedBox(height: DimensSizeV2.d16),
            _NewGroupButton(
              onPressed: wm.onPressedNewGroup,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onPressedEdit,
    required this.onPressedDone,
  });

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BrowserTextButton(
          title: LocaleKeys.edit.tr(),
          onPressed: onPressedEdit,
        ),
        Text(
          LocaleKeys.tabGroups.tr(),
          style: context.themeStyleV2.textStyles.labelMedium,
        ),
        BrowserTextButton(
          title: LocaleKeys.done.tr(),
          onPressed: onPressedDone,
        ),
      ],
    );
  }
}

class _GroupsList extends StatelessWidget {
  const _GroupsList({
    required this.groupsState,
    required this.activeGroupIdState,
    required this.editGroupsState,
    required this.onPressedItem,
    required this.onPressedEditGroup,
    required this.onPressedRemoveGroup,
  });

  final ListenableState<List<GroupData>> groupsState;
  final ListenableState<String?> activeGroupIdState;

  final ListenableState<bool> editGroupsState;

  final ValueChanged<String> onPressedItem;
  final ValueChanged<String> onPressedEditGroup;
  final ValueChanged<String> onPressedRemoveGroup;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: groupsState,
      builder: (_, List<GroupData>? list) {
        if (list == null) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: DimensSizeV2.d176,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: PrimaryShapedContainerColumn(
              backgroundColor: context.themeStyleV2.colors.background2,
              margin: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
              children: [
                for (final listenable in list)
                  BrowserGroupMenuItem(
                    key: ValueKey(listenable.value.id),
                    listenable: listenable,
                    activeGroupIdState: activeGroupIdState,
                    editGroupsState: editGroupsState,
                    onPressed: () => onPressedItem(listenable.value.id),
                    onPressedEdit: () =>
                        onPressedEditGroup(listenable.value.id),
                    onPressedRemove: () =>
                        onPressedRemoveGroup(listenable.value.id),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NewGroupButton extends StatelessWidget {
  const _NewGroupButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final style = theme.textStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
      child: CustomButton(
        buttonShape: ButtonShape.rectangle,
        onPressed: onPressed,
        buttonSize: ButtonSize.medium,
        postfixIcon: LucideIcons.plus,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        backgroundColor: theme.colors.background2,
        title: LocaleKeys.newEmptyGroup.tr(),
        textStyle: style.labelSmall,
      ),
    );
  }
}
