import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/back_up_badge.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Body of wallet, that displays information about account
class WalletAccountBodyWidget extends InjectedElementaryParametrizedWidget<
    WalletAccountBodyWidgetModel, KeyAccount> {
  const WalletAccountBodyWidget({
    required KeyAccount account,
    super.key,
  }) : super(wmFactoryParam: account);

  @override
  Widget build(WalletAccountBodyWidgetModel wm) {
    return SliverToBoxAdapter(
      child: Column(
        spacing: DimensSizeV2.d16,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d24,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
            ),
            child: ValueListenableBuilder(
              valueListenable: wm.currentAccountState,
              builder: (_, currentAccount, __) {
                return AccountCard(account: currentAccount);
              },
            ),
          ),
          MultiListenerRebuilder(
            listenableList: [
              wm.notificationsState,
              wm.currentAccountState,
            ],
            builder: (_) {
              final currentAccount = wm.currentAccountState.value;
              final notifications = wm.notificationsState.value ?? [];

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: WalletAccountActions(
                      account: currentAccount,
                      disableSensetiveActions: notifications.contains(
                        NotificationType.unsupportedWalletType,
                      ),
                    ),
                  ),
                  if (notifications.isNotEmpty)
                    Column(
                      spacing: DimensSizeV2.d8,
                      children: [
                        _Carousel(
                          items: notifications,
                          account: currentAccount,
                          onFinishedBackup: wm.onFinishedBackup,
                          onSwitchAccount: wm.onSwitchAccount,
                          onPageChanged: wm.onPageChanged,
                        ),
                        if (notifications.length > 1)
                          ValueListenableBuilder(
                            valueListenable: wm.carouselPageState,
                            builder: (_, page, __) => _CarouselIndicator(
                              currentPage: page,
                              itemCount: notifications.length,
                            ),
                          ),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.items,
    required this.account,
    required this.onFinishedBackup,
    required this.onSwitchAccount,
    required this.onPageChanged,
  });

  final List<NotificationType> items;
  final KeyAccount account;
  final ValueChanged<bool> onFinishedBackup;
  final VoidCallback onSwitchAccount;
  final void Function(
    int index,
    CarouselPageChangedReason reason,
  ) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: DimensSizeV2.d124,
        viewportFraction: 1,
        enableInfiniteScroll: items.length > 1,
        onPageChanged: onPageChanged,
      ),
      itemCount: items.length,
      itemBuilder: (_, i, __) {
        final child = switch (items[i]) {
          NotificationType.backup => BackUpBadge(
              currentAccount: account,
              finishedBackupCallback: onFinishedBackup,
            ),
          NotificationType.unsupportedWalletType => UnsupportedWalletTypeAlert(
              onSwitchAccount: onSwitchAccount,
            ),
        };

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d16,
          ),
          child: child,
        );
      },
    );
  }
}

class _CarouselIndicator extends StatelessWidget {
  const _CarouselIndicator({
    required this.currentPage,
    required this.itemCount,
  });

  final int currentPage;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d8),
      child: SizedBox(
        height: DimensSizeV2.d8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: DimensSizeV2.d8,
          children: List.generate(
            itemCount,
            (index) {
              final isActive = index == currentPage;
              final size = isActive ? DimensSizeV2.d8 : DimensSizeV2.d6;
              final color =
                  isActive ? theme.colors.content0 : theme.colors.background3;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: size,
                height: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              );
            },
          ),
        ),
      ),
    );
  }
}
