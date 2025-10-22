import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/request_permissions/account_list_item.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/request_permissions/request_permissions_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows choose account that should be used for browser tab with
/// specified origin URL.
/// This widget firstly asks to choose account and then confirms permissions.
class RequestPermissionsWidget
    extends
        InjectedElementaryParametrizedWidget<
          RequestPermissionsWidgetModel,
          RequestPermissionsWmParams
        > {
  RequestPermissionsWidget({
    required Uri origin,
    required List<Permission> permissions,
    required this.scrollController,
    required Address? previousSelectedAccount,
    super.key,
  }) : super(
         wmFactoryParam: RequestPermissionsWmParams(
           origin: origin,
           permissions: permissions,
           previousSelectedAccount: previousSelectedAccount,
         ),
       );

  final ScrollController scrollController;

  @override
  Widget build(RequestPermissionsWidgetModel wm) => ValueListenableBuilder(
    valueListenable: wm.stepState,
    builder: (context, value, child) => switch (value) {
      RequestPermissionsStep.account => _SelectAccountWidget(
        wm,
        scrollController,
      ),
      RequestPermissionsStep.confirm => _ConfirmPermissionsWidget(
        wm,
        scrollController,
      ),
    },
  );
}

class _SelectAccountWidget extends StatelessWidget {
  const _SelectAccountWidget(this.wm, this.scrollController);

  final RequestPermissionsWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SeparatedColumn(
            spacing: DimensSizeV2.d12,
            children: [
              ValueListenableBuilder(
                valueListenable: wm.originState,
                builder: (_, uri, __) {
                  return WebsiteInfoWidget(uri: uri);
                },
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
                    firstSource: wm.accountsState,
                    secondSource: wm.selectedState,
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
                        separatorBuilder: (_, __) =>
                            CommonDivider(color: theme.colors.border0),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        StateNotifierBuilder(
          listenableState: wm.selectedState,
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
  const _ConfirmPermissionsWidget(this.wm, this.scrollController);

  final RequestPermissionsWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final account = wm.selectedState.value!;

    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              spacing: DimensSizeV2.d12,
              children: [
                AccountInfo(account: account, color: theme.colors.background2),
                ValueListenableBuilder(
                  valueListenable: wm.originState,
                  builder: (_, uri, __) {
                    return WebsiteInfoWidget(uri: uri);
                  },
                ),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.requestedPermissions.tr(),
                        style: theme.textStyles.labelSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      const SizedBox(height: DimensSizeV2.d16),
                      ValueListenableBuilder(
                        valueListenable: wm.permissionsState,
                        builder: (_, value, __) {
                          final basic = value.contains(Permission.basic);
                          final accountInteraction = value.contains(
                            Permission.accountInteraction,
                          );

                          return SeparatedColumn(
                            spacing: DimensSizeV2.d12,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.basicInteractionType.tr(),
                                    style: theme.textStyles.labelSmall,
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: basic,
                                    onChanged: (value) => wm.onPermissionSwitch(
                                      permission: Permission.basic,
                                      checked: value,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.accountInteractionType.tr(),
                                    style: theme.textStyles.labelSmall,
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value: accountInteraction,
                                    onChanged: (value) => wm.onPermissionSwitch(
                                      permission: Permission.accountInteraction,
                                      checked: value,
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
                ),
              ],
            ),
          ),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.allowWord.tr(),
          onPressed: wm.onConfirm,
        ),
      ],
    );
  }
}
