import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/accent_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_shape.dart';

/// Widget that allows select local custodians to confirm multisig transaction
class TonWalletConfirmTransactionPrepare extends StatefulWidget {
  const TonWalletConfirmTransactionPrepare({
    required this.localCustodians,
    required this.custodianNames,
    required this.onCustodianSelected,
    super.key,
  });

  final List<PublicKey> localCustodians;
  final Map<PublicKey, String?> custodianNames;
  final void Function(PublicKey) onCustodianSelected;

  @override
  State<TonWalletConfirmTransactionPrepare> createState() =>
      _TonWalletConfirmTransactionPrepareState();
}

class _TonWalletConfirmTransactionPrepareState
    extends State<TonWalletConfirmTransactionPrepare> {
  late final custodianNotifier =
      ValueNotifier<PublicKey>(widget.localCustodians.first);

  @override
  void dispose() {
    custodianNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: SeparatedColumn(
        children: [
          ValueListenableBuilder<PublicKey>(
            valueListenable: custodianNotifier,
            builder: (context, value, _) {
              return CommonSelectDropdown<PublicKey>(
                values: widget.localCustodians
                    .map(
                      (c) => CommonSheetDropdownItem<PublicKey>(
                        value: c,
                        title: widget.custodianNames[c] ?? c.toEllipseString(),
                      ),
                    )
                    .toList(),
                titleText: LocaleKeys.custodianWord.tr(),
                currentValue: value,
                onChanged: (custodian) => custodianNotifier.value = custodian,
              );
            },
          ),
          const Spacer(),
          AccentButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.nextWord.tr(),
            onPressed: _onPressed,
          ),
        ],
      ),
    );
  }

  void _onPressed() => widget.onCustodianSelected(custodianNotifier.value);
}
