import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/change_network/change_network_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ChangeNetworkWidget extends InjectedElementaryParametrizedWidget<
    ChangeNetworkWidgetModel, ChangeNetworkWmParams> {
  ChangeNetworkWidget({
    required Uri origin,
    required int networkId,
    required List<ConnectionData> connections,
    required this.scrollController,
    super.key,
  }) : super(
          wmFactoryParam: ChangeNetworkWmParams(
            origin: origin,
            networkId: networkId,
            connections: connections,
          ),
        );

  final ScrollController scrollController;

  @override
  Widget build(ChangeNetworkWidgetModel wm) {
    final theme = wm.theme;

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
                  valueListenable: wm.originState,
                  builder: (_, origin, __) {
                    return WebsiteInfoWidget(uri: origin);
                  },
                ),
                MultiListenerRebuilder(
                  listenableList: [
                    wm.connectionsState,
                    wm.connection,
                  ],
                  builder: (_) {
                    final currentConnection = wm.connection.value;
                    final connections = wm.connectionsState.value;

                    if (connections.length < 2) return const SizedBox.shrink();

                    return CommonSelectDropdown<ConnectionData>(
                      values: [
                        for (final connection in connections)
                          CommonSheetDropdownItem<ConnectionData>(
                            value: connection,
                            title: connection.name,
                          ),
                      ],
                      titleText: LocaleKeys.networkWord.tr(),
                      currentValue: currentConnection,
                      onChanged: wm.onConnectionChanged,
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: wm.connection,
                  builder: (_, connection, __) => PrimaryCard(
                    color: theme.colors.background2,
                    borderRadius: BorderRadius.circular(
                      DimensRadiusV2.radius12,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: DimensSizeV2.d24,
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: SeparatedColumn(
                      spacing: DimensSizeV2.d16,
                      children: [
                        _Param(
                          label: LocaleKeys.networkId.tr(),
                          value: wm.networkIdState.toString(),
                        ),
                        _Param(
                          label: LocaleKeys.networkName.tr(),
                          value: connection.name,
                        ),
                        _Param(
                          label: LocaleKeys.networkType.tr(),
                          value: connection.networkType.name,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: wm.loading,
          builder: (_, loading, __) => AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.confirm.tr(),
            isLoading: loading,
            onPressed: wm.onConfirm,
          ),
        ),
      ],
    );
  }
}

class _Param extends StatelessWidget {
  const _Param({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SeparatedRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textStyles.paragraphSmall.copyWith(
            color: theme.colors.content3,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: theme.textStyles.paragraphSmall,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
