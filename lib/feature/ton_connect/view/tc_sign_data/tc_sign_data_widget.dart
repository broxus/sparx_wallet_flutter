import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TCSignDataWidget extends ElementaryWidget<TCSignDataWidgetModel> {
  const TCSignDataWidget({
    required this.connection,
    required this.payload,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultTCSignDataWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final TonAppConnection connection;
  final SignDataPayload payload;
  final ScrollController scrollController;

  @override
  Widget build(TCSignDataWidgetModel wm) {
    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AccountInfoWidget(account: connection.walletAddress),
                const SizedBox(height: DimensSizeV2.d12),
                StateNotifierBuilder(
                  listenableState: wm.manifest,
                  builder: (_, origin) =>
                      origin?.let(
                        (value) => WebsiteInfoWidget(
                          uri: Uri.parse(value.url),
                          iconUrl: Uri.tryParse(value.iconUrl),
                        ),
                      ) ??
                      const SizedBox.shrink(),
                ),
                const SizedBox(height: DimensSizeV2.d12),
                DataCard(data: payload.cell),
              ],
            ),
          ),
        ),
        if (wm.account != null)
          StateNotifierBuilder(
            listenableState: wm.isLoading,
            builder: (_, isLoading) => EnterPasswordWidgetV2(
              isLoading: isLoading,
              publicKey: wm.account!.publicKey,
              title: LocaleKeys.sign.tr(),
              onPasswordEntered: wm.onSubmit,
            ),
          ),
      ],
    );
  }
}
