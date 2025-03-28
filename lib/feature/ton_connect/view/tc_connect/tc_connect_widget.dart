import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/website_info/website_info.dart';
import 'package:app/feature/profile/widgets/widgets.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TCConnectWidget extends ElementaryWidget<TCConnectWidgetModel> {
  const TCConnectWidget({
    required this.request,
    required this.manifest,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultTCConnectWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final ConnectRequest request;
  final DappManifest manifest;
  final ScrollController scrollController;

  @override
  Widget build(TCConnectWidgetModel wm) => ValueListenableBuilder(
        valueListenable: wm.step,
        builder: (context, value, child) => switch (value) {
          TonConnectStep.account => _SelectAccountWidget(wm, scrollController),
          TonConnectStep.confirm => _ConfirmPermissionsWidget(wm),
        },
      );
}

class _SelectAccountWidget extends StatelessWidget {
  const _SelectAccountWidget(this.wm, this.scrollController);

  final TCConnectWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d12,
            children: [
              WebsiteInfoWidget(
                uri: Uri.parse(wm.manifest.url),
                iconUrl: Uri.tryParse(wm.manifest.iconUrl),
              ),
              PrimaryTextField(
                textEditingController: wm.searchController,
                hintText: LocaleKeys.searchWord.tr(),
                onChanged: (_) => wm.onSearch(),
                onSubmit: (_) => wm.onSearch(),
              ),
              Flexible(
                child: Container(
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colors.border1),
                    borderRadius: BorderRadius.circular(
                      DimensRadiusV2.radius12,
                    ),
                    color: theme.colors.background1,
                  ),
                  child: DoubleSourceBuilder(
                    firstSource: wm.accounts,
                    secondSource: wm.selected,
                    builder: (_, accounts, selected) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToActiveAccount(accounts, selected);
                      });
                      return ListView.separated(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: accounts?.length ?? 0,
                        itemBuilder: (_, index) {
                          final account = accounts?[index];
                          return account == null
                              ? const SizedBox.shrink()
                              : AccountListItem(
                                  key: ValueKey(account.address),
                                  account: account,
                                  balance: wm.getBalanceEntity(account),
                                  active: account.address == selected?.address,
                                  onTap: () => wm.onSelectedChanged(account),
                                );
                        },
                        separatorBuilder: (_, __) => CommonDivider(
                          color: theme.colors.border0,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        StateNotifierBuilder(
          listenableState: wm.selected,
          builder: (_, value) => AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: value != null ? wm.onNext : null,
          ),
        ),
      ],
    );
  }

  void _scrollToActiveAccount(
    List<KeyAccount>? accounts,
    KeyAccount? selected,
  ) {
    if (accounts != null && selected != null) {
      final index = accounts.indexWhere(
        (account) => account.address == selected.address,
      );

      if (index != -1) {
        scrollController.animateTo(
          index * DimensSizeV2.d72,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}

class _ConfirmPermissionsWidget extends StatelessWidget {
  const _ConfirmPermissionsWidget(this.wm);

  final TCConnectWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final account = wm.selected.value!;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: wm.scrollController,
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              children: [
                AccountInfo(
                  account: account,
                  color: theme.colors.background2,
                ),
                WebsiteInfoWidget(
                  uri: Uri.parse(wm.manifest.url),
                  iconUrl: Uri.tryParse(wm.manifest.iconUrl),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidgetV2(
          publicKey: account.publicKey,
          title: LocaleKeys.allowWord.tr(),
          onPasswordEntered: wm.onConfirm,
        ),
      ],
    );
  }
}
