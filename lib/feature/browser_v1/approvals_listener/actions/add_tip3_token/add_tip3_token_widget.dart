import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/add_tip3_token/add_tip3_token_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddTip3TokenWidget extends InjectedElementaryParametrizedWidget<
    AddTip3TokenWidgetModel, AddTip3TokenWmParams> {
  AddTip3TokenWidget({
    required Uri origin,
    required Address account,
    required TokenContractAsset details,
    required this.scrollController,
    super.key,
  }) : super(
          wmFactoryParam: AddTip3TokenWmParams(
            origin: origin,
            account: account,
            details: details,
          ),
        );

  final ScrollController scrollController;

  @override
  Widget build(AddTip3TokenWidgetModel wm) {
    final theme = wm.theme;
    final labelStyle = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    );
    final textStyle = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content0,
    );

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              spacing: DimensSizeV2.d12,
              children: [
                ValueListenableBuilder(
                  valueListenable: wm.accountState,
                  builder: (_, account, __) {
                    return AccountInfoWidget(account: account);
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: wm.originState,
                  builder: (_, origin, __) {
                    return WebsiteInfoWidget(uri: origin);
                  },
                ),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d24,
                    horizontal: DimensSizeV2.d16,
                  ),
                  child: SeparatedColumn(
                    spacing: DimensSizeV2.d16,
                    children: [
                      _InfoRow(
                        hint: StateNotifierBuilder(
                          listenableState: wm.statusState,
                          builder: (_, v) => _StatusText(status: v),
                        ),
                        children: [
                          SeparatedRow(
                            spacing: DimensSizeV2.d4,
                            children: [
                              StateNotifierBuilder(
                                listenableState: wm.statusState,
                                builder: (_, v) => _StatusIcon(status: v),
                              ),
                              Text(LocaleKeys.nameWord.tr(), style: labelStyle),
                            ],
                          ),
                          Flexible(
                            child: SeparatedRow(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StateNotifierBuilder(
                                  listenableState: wm.assetState,
                                  builder: (_, value) => value?.logoURI == null
                                      ? const SizedBox.shrink()
                                      : TonWalletIconWidget(
                                          path: value!.logoURI!,
                                          size: DimensSize.d20,
                                        ),
                                ),
                                Flexible(
                                  child: ValueListenableBuilder(
                                    valueListenable: wm.detailsState,
                                    builder: (_, details, __) {
                                      return Text(
                                        details.name,
                                        style: textStyle,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: wm.detailsState,
                        builder: (_, details, __) {
                          return _InfoRow(
                            children: [
                              Text(
                                LocaleKeys.symbolWord.tr(),
                                style: labelStyle,
                              ),
                              Flexible(
                                child: Text(
                                  details.symbol,
                                  style: textStyle,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: wm.detailsState,
                        builder: (_, details, __) {
                          return _InfoRow(
                            children: [
                              Text(
                                LocaleKeys.decimalsWord.tr(),
                                style: labelStyle,
                              ),
                              Flexible(
                                child: Text(
                                  details.decimals.toString(),
                                  style: textStyle,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      _InfoRow(
                        children: [
                          Text(
                            LocaleKeys.currentBalanceLabel.tr(),
                            style: labelStyle,
                          ),
                          Flexible(
                            child: MultiListenerRebuilder(
                              listenableList: [
                                wm.detailsState,
                                wm.balanceState,
                              ],
                              builder: (_) {
                                final details = wm.detailsState.value;
                                final balance = wm.balanceState.value;

                                return AmountWidget.fromMoney(
                                  amount: balance ??
                                      Money.fromIntWithCurrency(
                                        0,
                                        Currency.create(details.symbol, 0),
                                      ),
                                  style: textStyle,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SeparatedColumn(
                        spacing: DimensSizeV2.d2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.symbolWord.tr(), style: labelStyle),
                          ValueListenableBuilder(
                            valueListenable: wm.detailsState,
                            builder: (_, details, __) {
                              return Text(
                                details.address.address,
                                style: textStyle,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.addWord.tr(),
          onPressed: wm.onConfirm,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.children,
    this.hint,
  });

  final List<Widget> children;
  final Widget? hint;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: DimensSize.d40),
        child: hint == null
            ? SeparatedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              )
            : SeparatedColumn(
                spacing: DimensSizeV2.d12,
                children: [
                  SeparatedRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                  hint!,
                ],
              ),
      );
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.status,
  });

  final TokenStatus? status;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return switch (status) {
      TokenStatus.trusted => Icon(
          LucideIcons.shieldCheck,
          size: DimensSize.d20,
          color: colors.contentPositive,
        ),
      TokenStatus.untrasted || TokenStatus.suggestion => Icon(
          LucideIcons.shieldOff,
          size: DimensSize.d20,
          color: colors.contentWarning,
        ),
      TokenStatus.explicit || TokenStatus.sameSymbol => Icon(
          LucideIcons.shieldAlert,
          size: DimensSize.d20,
          color: colors.contentNegative,
        ),
      null => const SizedBox.shrink(),
    };
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({
    required this.status,
  });

  final TokenStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return switch (status) {
      TokenStatus.untrasted => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundWarning,
          child: Text(
            LocaleKeys.untrastedTokenWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentWarning,
            ),
          ),
        ),
      TokenStatus.suggestion => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundWarning,
          child: Text(
            LocaleKeys.phishingSuggestionWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentWarning,
            ),
          ),
        ),
      TokenStatus.explicit => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundNegative,
          child: Text(
            LocaleKeys.phishingExplicitWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentNegative,
            ),
          ),
        ),
      TokenStatus.sameSymbol => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundNegative,
          child: Text(
            LocaleKeys.phishingSameSymbolWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentNegative,
            ),
          ),
        ),
      TokenStatus.trusted || null => const SizedBox.shrink(),
    };
  }
}
