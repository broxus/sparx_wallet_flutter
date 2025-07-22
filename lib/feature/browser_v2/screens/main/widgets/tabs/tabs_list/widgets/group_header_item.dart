import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserGroupHeaderItem extends StatelessWidget {
  const BrowserGroupHeaderItem({
    required this.width,
    required this.browserGroup,
    required this.selectedGroupIdListenable,
    required this.onPressed,
    super.key,
  });

  final double width;
  final NotNullListenableState<BrowserGroup> browserGroup;
  final ValueListenable<String?> selectedGroupIdListenable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: MultiListenerRebuilder(
                listenableList: [
                  browserGroup,
                  selectedGroupIdListenable,
                ],
                builder: (_) {
                  final group = browserGroup.value;
                  final selectedGroupId = selectedGroupIdListenable.value;

                  return Text(
                    group.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: group.id == selectedGroupId
                        ? styles.labelMedium
                        : styles.labelSmall.copyWith(
                            color: colors.content2,
                          ),
                  );
                },
              ),
            ),
            StateNotifierBuilder(
              listenableState: browserGroup,
              builder: (_, BrowserGroup? group) {
                if (group == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(left: DimensSizeV2.d4),
                  child: DecoratedBox(
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
                          group.tabsCountText,
                          minFontSize: 1,
                          style: styles.labelXSmall,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
