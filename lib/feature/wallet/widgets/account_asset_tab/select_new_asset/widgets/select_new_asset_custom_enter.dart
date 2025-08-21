import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/input_formatters.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows user to enter address of root token contract to add
/// it to account.
class SelectNewAssetCustomEnter extends StatefulWidget {
  const SelectNewAssetCustomEnter({
    required this.focus,
    required this.contracts,
    required this.onAddCustom,
    required this.onInvalidPaste,
    required this.onEnableAsset,
    required this.onDisableAsset,
    super.key,
  });

  final FocusNode focus;
  final List<(TokenContractAsset, bool)> contracts;
  final void Function(Address) onAddCustom;
  final VoidCallback onInvalidPaste;
  final void Function(Address) onEnableAsset;
  final void Function(Address) onDisableAsset;

  @override
  State<SelectNewAssetCustomEnter> createState() =>
      _SelectNewAssetCustomEnterState();
}

class _SelectNewAssetCustomEnterState extends State<SelectNewAssetCustomEnter> {
  final addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              spacing: DimensSizeV2.d16,
              children: [
                PrimaryTextField(
                  hintText: LocaleKeys.rootTokenContract.tr(),
                  textEditingController: addressController,
                  onSubmit: _onSubmit,
                  inputFormatters: [
                    InputFormatters.noSpacesFormatter,
                  ],
                  suffixes: [
                    ClipboardPasteButton(
                      value: addressController,
                      onClear: _onClear,
                      onPaste: _paste,
                    ),
                  ],
                ),
                SeparatedColumn(
                  spacing: DimensSizeV2.d12,
                  children: [
                    ...widget.contracts.map(
                      (pair) => SelectNewAssetItem(
                        asset: pair.$1,
                        isSelected: pair.$2,
                        onEnable: widget.onEnableAsset,
                        onDisable: widget.onDisableAsset,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: addressController,
          builder: (_, value, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d12),
            child: Padding(
              padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
              child: AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.proceedWord.tr(),
                onPressed: value.text.isNotEmpty ? _enable : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit(String? _) => _enable();

  void _onClear() {
    widget.focus.unfocus();
    addressController.clear();
  }

  void _enable() {
    widget.focus.unfocus();

    widget.onAddCustom(Address(address: addressController.text.trim()));
  }

  void _paste(String text) {
    if (text.isEmpty) return;

    final isValid = validateAddress(Address(address: text));
    if (isValid) {
      addressController.text = text;
    } else {
      widget.onInvalidPaste();
    }
  }
}
