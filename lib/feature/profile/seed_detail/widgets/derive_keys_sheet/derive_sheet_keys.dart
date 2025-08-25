import 'dart:math' as math;

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/seed_detail/seed_detail.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that displays [DeriveKeysSheet] sheet.
/// Showing this sheet means, that [password] is correct for [publicKey].
ModalRoute<void> deriveKeysSheet(
  BuildContext context,
  PublicKey publicKey, [
  String? password,
]) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.selectKeysYouNeed.tr(),
    padding: EdgeInsets.zero,
    body: (_, controller) => DeriveKeysSheet(
      controller: controller,
      masterKey: publicKey,
      password: password,
    ),
  );
}

const _itemHeight = DimensSizeV2.d56;
const _containerHeight = _itemHeight * derivedKeysPerPage +
    (DimensSizeV2.d4 * 2 + CommonDivider.size) * (derivedKeysPerPage - 1);

/// Widget that shows keys that could be derived from publicKey of seed.
class DeriveKeysSheet extends InjectedElementaryParametrizedWidget<
    DeriveKeysSheetWidgetModel, DeriveKeysSheetParams> {
  DeriveKeysSheet({
    required this.controller,
    required this.masterKey,
    this.password,
    super.key,
  }) : super(
          wmFactoryParam: DeriveKeysSheetParams(
            publicKey: masterKey,
            password: password,
          ),
        );

  final ScrollController controller;
  final PublicKey masterKey;
  final String? password;

  @override
  Widget build(DeriveKeysSheetWidgetModel wm) {
    return ValueListenableBuilder<DeriveKeysState>(
      valueListenable: wm.state,
      builder: (context, s, _) {
        if (s.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          });
        }
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensSizeV2.d16,
                ),
                child: SizedBox(
                  height: _containerHeight,
                  child: s.displayDerivedKeys.isEmpty && s.isLoading
                      ? const Center(
                          child: ProgressIndicatorWidget(
                            size: DimensSizeV2.d40,
                          ),
                        )
                      : SeparatedColumn(
                          mainAxisSize: MainAxisSize.min,
                          separator: const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: DimensSizeV2.d4),
                            child: CommonDivider(),
                          ),
                          children: [
                            for (final k in s.displayDerivedKeys)
                              _Item(
                                masterKey: masterKey,
                                derivedKey: k,
                                name: s.keyNames[k.publicKey],
                                isSelected:
                                    s.selectedKeys.contains(k.publicKey),
                                onChecked: wm.checkKey,
                                onUnchecked: wm.uncheckKey,
                              ),
                          ],
                        ),
                ),
              ),
            ),
            Column(
              children: [
                const CommonDivider(),
                _Pages(
                  currentPageIndex: s.currentPageIndex,
                  canPrevPage: s.canPrevPage,
                  canNextPage: s.canNextPage,
                  onPrevPage: () => wm.prevPage(),
                  onNextPage: () => wm.nextPage(),
                  onPage: (i) => wm.selectPage(i),
                ),
                const CommonDivider(),
                const SizedBox(height: DimensSizeV2.d8),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d16,
              ),
              child: PrimaryButton(
                isLoading: s.isLoading,
                title: LocaleKeys.selectWord.tr(),
                onPressed: wm.select,
                buttonShape: ButtonShape.pill,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    required this.currentPageIndex,
    required this.canPrevPage,
    required this.canNextPage,
    required this.onPrevPage,
    required this.onNextPage,
    required this.onPage,
  });

  final int currentPageIndex;
  final bool canPrevPage;
  final bool canNextPage;
  final VoidCallback onPrevPage;
  final VoidCallback onNextPage;
  final ValueChanged<int> onPage;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
      color: theme.colors.background1,
      child: SeparatedRow(
        children: [
          CommonIconButton.svg(
            svg: Assets.images.caretLeft24.path,
            buttonType: EverButtonType.ghost,
            onPressed: canPrevPage ? onPrevPage : null,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // This count is a sliding window though
                // available pages, that allows us to display up
                // to 50% of this variable on the left side and
                // up to 50% on the right side (we are trying to
                // put current page in center if possible)
                var maxCount = constraints.maxWidth ~/ DimensSizeV2.d40;
                maxCount = math.min(maxCount, derivePageCount);

                // do not subtract 1 here trying to compensate
                // width if count is even
                final possibleLeftPadding = maxCount ~/ 2;
                final availableLeftWindowIndex = math.max(
                  currentPageIndex - possibleLeftPadding,
                  0,
                );

                // subtract one trying to get real 50%
                final possibleRightPadding = (maxCount - 1) ~/ 2;
                final availableRightWindowIndex = math.min(
                  currentPageIndex + possibleRightPadding,
                  derivePageCount - 1,
                );
                // Compensate right padding if window is close
                // to right side.
                // Left side will be compensated by window size.
                final compensateRightToLeft = availableRightWindowIndex -
                    currentPageIndex -
                    possibleRightPadding;

                final startIndexOffset =
                    availableLeftWindowIndex + compensateRightToLeft;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(maxCount, (i) {
                    final index = i + startIndexOffset;

                    return PressScaleWidget(
                      onPressed: () => onPage(index),
                      child: Container(
                        height: DimensSizeV2.d40,
                        width: DimensSizeV2.d40,
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: StyleRes.button.copyWith(
                            color: index == currentPageIndex
                                ? theme.colors.content0
                                : theme.colors.content3,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          CommonIconButton.svg(
            svg: Assets.images.caretRight24.path,
            buttonType: EverButtonType.ghost,
            onPressed: canNextPage ? onNextPage : null,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.masterKey,
    required this.derivedKey,
    required this.isSelected,
    required this.name,
    required this.onChecked,
    required this.onUnchecked,
  });

  final PublicKey masterKey;
  final DerivedKeyWithIndex derivedKey;
  final bool isSelected;
  final String? name;
  final ValueChanged<DerivedKeyWithIndex> onChecked;
  final ValueChanged<DerivedKeyWithIndex> onUnchecked;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final theme = context.themeStyleV2;
    final disabled = derivedKey.publicKey == masterKey;

    return CommonListTile(
      // ignore: avoid_redundant_argument_values
      height: _itemHeight,
      leading: CommonBackgroundedIconWidget.svg(
        svg: Assets.images.key.path,
        backgroundColor: theme.colors.backgroundAlpha,
      ),
      titleText: name ?? derivedKey.publicKey.toEllipseString(),
      trailing: CommonIconWidget.svg(
        svg: isSelected
            ? Assets.images.checkSquare.path
            : Assets.images.checkEmpty.path,
        color: disabled
            ? colors.textSecondary
            : isSelected
                ? colors.textPrimary
                : colors.strokePrimary,
      ),
      onPressed: disabled
          ? null
          : () => isSelected ? onUnchecked(derivedKey) : onChecked(derivedKey),
    );
  }
}
