import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser/screens/main/widgets/browser_text_button.dart';
import 'package:app/feature/browser/screens/main/widgets/groups_menu/browser_group_menu_wm.dart';
import 'package:app/feature/browser/screens/main/widgets/groups_menu/widgets/item.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _browserGroupMenuHeight = 348.0;
const _groupsListHeight = 176.0;
const _headerBottomSpacing = 22.0;

Future<void> showBrowserTabMenu(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withAlpha(204),
    useRootNavigator: true,
    builder: (_) {
      return const SafeArea(child: BrowserGroupMenu());
    },
  );
}

class BrowserGroupMenu
    extends InjectedElementaryWidget<BrowserGroupMenuWidgetModel> {
  const BrowserGroupMenu({super.key});

  @override
  Widget build(BrowserGroupMenuWidgetModel wm) {
    return SizedBox(
      width: double.infinity,
      height: _browserGroupMenuHeight,
      child: PrimaryBottomSheetContainer(
        backgroundColor: ColorsRes.n15,
        child: Column(
          children: [
            _Header(
              onPressedEdit: wm.onPressedEditAll,
              onPressedDone: wm.onPressedDone,
            ),
            const SizedBox(height: _headerBottomSpacing),
            _GroupsList(
              groupsState: wm.groupsState,
              activeGroupIdState: wm.activeGroupIdState,
              editGroupsState: wm.editGroupsState,
              onPressedItem: wm.onPressedItem,
              onPressedEditGroup: wm.onPressedEditGroup,
              onPressedRemoveGroup: wm.onPressedRemoveGroup,
            ),
            const SizedBox(height: DimensSize.d16),
            _NewGroupButton(onPressed: wm.onPressedNewGroup),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onPressedEdit, required this.onPressedDone});

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
          style: context.themeStyle.textStyles.labelMedium,
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
          height: _groupsListHeight,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: PrimaryShapedContainerColumn(
              backgroundColor: context.themeStyle.colors.background2,
              margin: const EdgeInsets.symmetric(horizontal: DimensSize.d24),
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
  const _NewGroupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;
    final style = theme.textStyles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d24),
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
