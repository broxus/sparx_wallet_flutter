import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:app/feature/profile/widgets/widgets.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TCConnectWidget
    extends
        InjectedElementaryParametrizedWidget<
          TCConnectWidgetModel,
          TCConnectWmParams
        > {
  TCConnectWidget({
    required ConnectRequest request,
    required DappManifest manifest,
    required this.scrollController,
    super.key,
  }) : super(
         wmFactoryParam: TCConnectWmParams(
           request: request,
           manifest: manifest,
         ),
       );

  final ScrollController scrollController;

  @override
  Widget build(TCConnectWidgetModel wm) {
    return ValueListenableBuilder(
      valueListenable: wm.stepState,
      builder: (context, value, child) => switch (value) {
        TonConnectStep.account => _SelectAccountWidget(wm, scrollController),
        TonConnectStep.confirm => _ConfirmPermissionsWidget(
          wm,
          scrollController,
        ),
      },
    );
  }
}

class _SelectAccountWidget extends StatelessWidget {
  const _SelectAccountWidget(this.wm, this.scrollController);

  final TCConnectWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;

    return SeparatedColumn(
      spacing: DimensSize.d12,
      children: [
        Expanded(
          child: SeparatedColumn(
            spacing: DimensSize.d12,
            children: [
              WebsiteInfoWidget(
                uri: wm.manifest.url,
                iconUrl: Uri.tryParse(wm.manifest.iconUrl),
              ),
              PrimaryTextField(
                textEditingController: wm.searchController,
                hintText: LocaleKeys.searchWord.tr(),
              ),
              Flexible(
                child: Container(
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colors.border1),
                    borderRadius: BorderRadius.circular(DimensRadius.radius12),
                    color: theme.colors.background1,
                  ),
                  child: AccountListWidget(
                    selectedAccountState: wm.selectedState,
                    onSelectedChanged: wm.onSelectedChanged,
                    searchController: wm.searchController,
                    scrollController: scrollController,
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
}

class _ConfirmPermissionsWidget extends StatelessWidget {
  const _ConfirmPermissionsWidget(this.wm, this.scrollController);

  final TCConnectWidgetModel wm;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;
    final account = wm.selectedState.value!;

    return SeparatedColumn(
      spacing: DimensSize.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              spacing: DimensSize.d12,
              children: [
                AccountInfo(account: account, color: theme.colors.background2),
                WebsiteInfoWidget(
                  uri: wm.manifest.url,
                  iconUrl: Uri.tryParse(wm.manifest.iconUrl),
                ),
              ],
            ),
          ),
        ),
        EnterPasswordWidget.auth(
          getLedgerAuthInput: wm.getLedgerAuthInput,
          publicKey: account.publicKey,
          title: LocaleKeys.allowWord.tr(),
          onConfirmed: wm.onConfirm,
        ),
      ],
    );
  }
}
