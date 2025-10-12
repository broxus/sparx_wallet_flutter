import 'package:app/feature/ledger/ledger.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ImportLedgerWidget extends ElementaryWidget<ImportLedgerWidgetModel> {
  const ImportLedgerWidget({
    this.name,
    Key? key,
    WidgetModelFactory wmFactory = defaultImportLedgerWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final String? name;

  @override
  Widget build(ImportLedgerWidgetModel wm) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d24),
      child: StateNotifierBuilder(
        listenableState: wm.isSelectedState,
        builder: (_, isSelected) {
          if (isSelected ?? false) {
            return _Connect(
              isConnected: wm.isConnectedState,
              isInitialized: wm.isInitializedState,
              isLoading: wm.isLoadingState,
              onContinue: wm.onContinue,
              onCancel: wm.onCancel,
            );
          }

          return _BleList(
            scanResult: wm.scanResultState,
            isBluetoothEnabled: wm.isBluetoothEnabledState,
            onSelect: wm.onScanResultSelected,
            onCancel: wm.onCancel,
          );
        },
      ),
    );
  }
}

class _BleList extends StatelessWidget {
  const _BleList({
    required this.scanResult,
    required this.isBluetoothEnabled,
    required this.onSelect,
    required this.onCancel,
  });

  final ListenableState<List<ScanResult>> scanResult;
  final ListenableState<bool> isBluetoothEnabled;
  final ValueChanged<ScanResult> onSelect;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DimensSizeV2.d16,
      children: [
        Text(
          LocaleKeys.availableDevices.tr(),
          style: theme.textStyles.headingMedium,
          textAlign: TextAlign.center,
        ),
        DoubleSourceBuilder(
          firstSource: scanResult,
          secondSource: isBluetoothEnabled,
          builder: (_, scanResult, isBluetoothEnabled) {
            if (isBluetoothEnabled == false) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d16,
                  ),
                  child: Icon(
                    LucideIcons.bluetoothOff,
                    size: DimensSizeV2.d40,
                    color: theme.colors.content0,
                  ),
                ),
              );
            }

            final items = scanResult?.map((item) {
                  final name = item.advertisementData.advName;
                  final model = item.getLedgerDeviceModel();

                  if (model == null) return null;

                  return CommonListTile(
                    padding: EdgeInsets.zero,
                    height: DimensSizeV2.d40,
                    leading: CommonBackgroundedIconWidget.icon(
                      icon: LucideIcons.bluetooth,
                      iconColor: theme.colors.content0,
                      backgroundColor: theme.colors.background3,
                    ),
                    trailing: const Icon(
                      LucideIcons.chevronRight,
                      size: DimensSizeV2.d20,
                    ),
                    titleChild: Text(
                      name.isNotEmpty
                          ? '$name (${model.productName})'
                          : model.productName,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    onPressed: () => onSelect(item),
                  );
                }).nonNulls ??
                [];

            return ShapedContainerColumn(
              color: theme.colors.background2,
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              margin: EdgeInsets.zero,
              separator: const CommonDivider(
                margin: EdgeInsets.symmetric(vertical: DimensSizeV2.d16),
              ),
              children: [
                ...items,
                if (items.isEmpty)
                  const Center(
                    child: ProgressIndicatorWidget(
                      size: DimensSizeV2.d40,
                    ),
                  ),
              ],
            );
          },
        ),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: onCancel,
        ),
      ],
    );
  }
}

class _Connect extends StatelessWidget {
  const _Connect({
    required this.isConnected,
    required this.isInitialized,
    required this.isLoading,
    required this.onContinue,
    required this.onCancel,
  });

  final ListenableState<bool> isConnected;
  final ListenableState<bool> isInitialized;
  final ListenableState<bool> isLoading;
  final VoidCallback onContinue;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.connectLedger.tr(),
          style: theme.textStyles.headingMedium,
        ),
        const SizedBox(height: DimensSizeV2.d16),
        DoubleSourceBuilder(
          firstSource: isConnected,
          secondSource: isInitialized,
          builder: (_, isConnected, isInitialized) => LedgerStatusContainer(
            steps: [
              LedgerInteractionStep(
                title: LocaleKeys.ledgerStepConnectTitle.tr(),
                state: (isConnected ?? false)
                    ? LedgerInteractionStepState.success
                    : LedgerInteractionStepState.loading,
              ),
              LedgerInteractionStep(
                title: LocaleKeys.ledgerStepAppTitle.tr(),
                state: switch ((isConnected, isInitialized)) {
                  (_, true) => LedgerInteractionStepState.success,
                  (true, false) => LedgerInteractionStepState.loading,
                  _ => LedgerInteractionStepState.initial,
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        DoubleSourceBuilder(
          firstSource: isInitialized,
          secondSource: isLoading,
          builder: (_, isInitialized, isLoading) => PrimaryButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.continueWord.tr(),
            isLoading: isLoading ?? false,
            onPressed: (isInitialized ?? false) ? onContinue : null,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d8),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: onCancel,
        ),
      ],
    );
  }
}
