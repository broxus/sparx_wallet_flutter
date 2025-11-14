import 'dart:convert';

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

class TCSignDataWidget
    extends
        InjectedElementaryParametrizedWidget<
          TCSignDataWidgetModel,
          TCSignDataWmParams
        > {
  TCSignDataWidget({
    required TonAppConnection connection,
    required SignDataPayload payload,
    required DappManifest manifest,
    required this.scrollController,
    super.key,
  }) : super(
         wmFactoryParam: TCSignDataWmParams(
           connection: connection,
           payload: payload,
           manifest: manifest,
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
                  valueListenable: wm.connectionState,
                  builder: (_, connection, __) {
                    return AccountInfoWidget(account: connection.walletAddress);
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                ValueListenableBuilder(
                  valueListenable: wm.connectionState,
                  builder: (_, connection, __) {
                    return WebsiteInfoWidget(
                      uri: Uri.parse(connection.manifest.url),
                      iconUrl: Uri.tryParse(connection.manifest.iconUrl),
                    );
                  },
                ),
                const SizedBox(height: DimensSizeV2.d12),
                ValueListenableBuilder(
                  valueListenable: wm.payloadState,
                  builder: (_, payload, __) {
                    final data = switch (payload) {
                      SignDataPayloadCell(:final cell) => cell,
                      SignDataPayloadText(:final text) => base64Encode(
                        utf8.encode(text),
                      ),
                      SignDataPayloadBinary(:final bytes) => bytes,
                    };
                    return DataCard(data: data);
                  },
                ),
              ],
            ),
          ),
        ),
        MultiListenerRebuilder(
          listenableList: [wm.accountState, wm.isLoadingState],
          builder: (_) {
            final account = wm.accountState.value;
            final isLoading = wm.isLoadingState.value;

            if (account == null) return const SizedBox.shrink();

            return EnterPasswordWidget.auth(
              getLedgerAuthInput: wm.getLedgerAuthInput,
              isLoading: isLoading ?? false,
              publicKey: account.publicKey,
              title: LocaleKeys.sign.tr(),
              onConfirmed: wm.onSubmit,
            );
          },
        ),
      ],
    );
  }
}
