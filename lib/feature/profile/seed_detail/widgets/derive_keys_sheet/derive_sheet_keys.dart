import 'dart:math' as math;

import 'package:app/di/di.dart';
import 'package:app/feature/profile/seed_detail/widgets/derive_keys_sheet/derive_keys_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that displays [DeriveKeysSheet] sheet.
/// Showing this sheet means, that [password] is correct for [publicKey].
ModalRoute<void> deriveKeysSheet(
  BuildContext context,
  PublicKey publicKey,
  String password,
) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.selectKeysYouNeed.tr(),
    padding: EdgeInsets.zero,
    body: (_, controller) => BlocProvider<DeriveKeysCubit>(
      create: (context) => DeriveKeysCubit(
        inject<NekotonRepository>(),
        publicKey,
        password,
      )..init(),
      child: DeriveKeysSheet(
        controller: controller,
        masterKey: publicKey,
      ),
    ),
  );
}

/// Widget that shows keys that could be derived from publicKey of seed.
class DeriveKeysSheet extends StatelessWidget {
  const DeriveKeysSheet({
    required this.controller,
    required this.masterKey,
    super.key,
  });

  final ScrollController controller;

  /// For master key changing its state must be disabled (it's always checked)
  final PublicKey masterKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeriveKeysCubit, DeriveKeysState>(
      listener: (context, state) => switch (state) {
        DeriveKeysStateData(:final isCompleted) when isCompleted =>
          Navigator.of(context).pop(),
        _ => null,
      },
      builder: (context, state) {
        return switch (state) {
          DeriveKeysStateInitial() => const SizedBox.shrink(),
          DeriveKeysStateData(
            :final canPrevPage,
            :final canNextPage,
            :final currentPageIndex,
            :final displayDerivedKeys,
            :final selectedKeys,
            :final keyNames,
            :final isLoading,
          ) =>
            SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    controller: controller,
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ),
                    child: SeparatedColumn(
                      mainAxisSize: MainAxisSize.min,
                      separator: const Padding(
                        padding: EdgeInsets.symmetric(vertical: DimensSize.d4),
                        child: CommonDivider(),
                      ),
                      children: displayDerivedKeys
                          .map(
                            (k) => _keyItem(
                              key: k,
                              name: keyNames[k],
                              isSelected: selectedKeys.contains(k),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const CommonDivider(),
                    _pagesBuilder(
                      currentPageIndex: currentPageIndex,
                      canPrevPage: canPrevPage,
                      canNextPage: canNextPage,
                    ),
                    const CommonDivider(),
                    const SizedBox(height: DimensSize.d8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSize.d16,
                  ),
                  child: _selectButton(isLoading),
                ),
              ],
            ),
        };
      },
    );
  }

  // ignore: long-method
  Widget _pagesBuilder({
    required int currentPageIndex,
    required bool canPrevPage,
    required bool canNextPage,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          color: theme.colors.background1,
          child: SeparatedRow(
            children: [
              CommonIconButton.svg(
                svg: Assets.images.caretLeft24.path,
                buttonType: EverButtonType.ghost,
                onPressed: canPrevPage
                    ? () => context.read<DeriveKeysCubit>().prevPage()
                    : null,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // This count is a sliding window though
                    // available pages, that allows us to display up
                    // to 50% of this variable on the left side and
                    // up to 50% on the right side (we are trying to
                    // put current page in center if possible)
                    var maxCount = constraints.maxWidth ~/ DimensSize.d40;
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
                          onPressed: () =>
                              context.read<DeriveKeysCubit>().selectPage(index),
                          child: Container(
                            height: DimensSize.d40,
                            width: DimensSize.d40,
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
                onPressed: canNextPage
                    ? () => context.read<DeriveKeysCubit>().nextPage()
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _selectButton(bool isLoading) {
    return Builder(
      builder: (context) {
        return PrimaryButton(
          isLoading: isLoading,
          title: LocaleKeys.selectWord.tr(),
          onPressed: () => context.read<DeriveKeysCubit>().select(),
          buttonShape: ButtonShape.pill,
        );
      },
    );
  }

  Widget _keyItem({
    required PublicKey key,
    required bool isSelected,
    String? name,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final theme = context.themeStyleV2;
        final disabled = key == masterKey;

        return CommonListTile(
          onPressed: disabled
              ? null
              : () => isSelected
                  ? context.read<DeriveKeysCubit>().uncheckKey(key)
                  : context.read<DeriveKeysCubit>().checkKey(key),
          leading: CommonBackgroundedIconWidget.svg(
            svg: Assets.images.key.path,
            backgroundColor: theme.colors.backgroundAlpha,
          ),
          titleText: name ?? key.toEllipseString(),
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
        );
      },
    );
  }
}
