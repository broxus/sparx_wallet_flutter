import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserGroupMenuItem extends StatelessWidget {
  const BrowserGroupMenuItem({
    required this.count,
    required this.isActive,
    required this.isEditable,
    required this.isEdit,
    required this.onPressed,
    required this.onPressedEdit,
    required this.onPressedRemove,
    this.name,
    super.key,
  });

  final String? name;

  final int count;
  final bool isActive;
  final bool isEditable;
  final bool isEdit;

  final VoidCallback onPressed;
  final VoidCallback onPressedEdit;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final styles = theme.textStyles;
    final colors = theme.colors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        height: DimensSizeV2.d44,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: DimensSizeV2.d16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: DimensSizeV2.d8,
                        children: [
                          Text(
                            name ?? '',
                            style: styles.labelSmall.copyWith(
                              color:
                                  isActive ? colors.content0 : colors.content2,
                            ),
                          ),
                          DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // TODO(knightforce): add to color palette
                              color: Color(0xff353960),
                            ),
                            child: SizedBox(
                              width: DimensSizeV2.d20,
                              height: DimensSizeV2.d20,
                              child: Center(
                                child: AutoSizeText(
                                  '$count',
                                  minFontSize: 1,
                                  style: styles.labelXSmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isEditable && isEdit)
                    _Menu(
                      onPressedEdit: onPressedEdit,
                      onPressedRemove: onPressedRemove,
                    )
                  else if (isActive)
                    const Padding(
                      padding: EdgeInsets.only(
                        right: DimensSizeV2.d16,
                      ),
                      child: Icon(
                        LucideIcons.check,
                        size: DimensSizeV2.d16,
                      ),
                    ),
                ],
              ),
            ),
            if (isEditable && !isEdit)
              SizedBox(
                height: double.infinity,
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    extentRatio: 0.24,
                    //dragDismissible: false,
                    children: [
                      _MenuButton(
                        icon: LucideIcons.pencilLine,
                        color: colors.primaryA,
                        onPressed: onPressedEdit,
                      ),
                      Container(
                        width: .5,
                        color: colors.content3,
                      ),
                      _MenuButton(
                        icon: LucideIcons.trash2,
                        color: ColorsResV2.e50,
                        onPressed: onPressedRemove,
                      ),
                    ],
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    required this.onPressedEdit,
    required this.onPressedRemove,
  });

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _MenuButton(
          icon: LucideIcons.pencilLine,
          color: colors.primaryA,
          onPressed: onPressedEdit,
        ),
        _MenuButton(
          icon: LucideIcons.trash2,
          color: ColorsResV2.e50,
          onPressed: onPressedRemove,
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: DimensSizeV2.d40,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.themeStyleV2.colors.background2,
          ),
          child: Icon(
            icon,
            color: color,
            size: DimensSizeV2.d16,
          ),
        ),
      ),
    );
  }
}
