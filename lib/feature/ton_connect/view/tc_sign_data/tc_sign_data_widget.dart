import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/account_info/account_info_widget.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/data_card.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TCSignDataWidget extends InjectedElementaryParametrizedWidget<
    TCSignDataWidgetModel, TCSignDataWmParams> {
  TCSignDataWidget({
    required TonAppConnection connection,
    required SignDataPayload payload,
    required this.scrollController,
    super.key,
  }) : super(
          wmFactoryParam: TCSignDataWmParams(
            connection: connection,
            payload: payload,
          ),
        );

  final ScrollController scrollController;

  @override
  Widget build(TCSignDataWidgetModel wm) {
    return SeparatedColumn(
      spacing: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder(
                  valueListenable: wm.connection,
                  builder: (_, connection, __) {
                    return AccountInfoWidget(account: connection.walletAddress);
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                ValueListenableBuilder(
                  valueListenable: wm.connection,
                  builder: (_, connection, __) {
                    return WebsiteInfoWidget(
                      uri: Uri.parse(connection.manifest.url),
                      iconUrl: Uri.tryParse(connection.manifest.iconUrl),
                    );
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                ValueListenableBuilder(
                  valueListenable: wm.payload,
                  builder: (_, payload, __) {
                    return DataCard(data: payload.cell);
                  },
                ),
              ],
            ),
          ),
        ),
        MultiListenerRebuilder(
          listenableList: [
            wm.accountState,
            wm.isLoading,
          ],
          builder: (_) {
            final account = wm.accountState.value;
            final isLoading = wm.isLoading.value;

            if (account == null) return const SizedBox.shrink();

            return EnterPasswordWidgetV2(
              isLoading: isLoading,
              publicKey: account.publicKey,
              title: LocaleKeys.sign.tr(),
              onPasswordEntered: wm.onSubmit,
            );
          },
        ),
      ],
    );
  }
}
