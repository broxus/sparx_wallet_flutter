import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/input/common_select_dropdown.dart';

class CustodianDropdown extends StatelessWidget {
  const CustodianDropdown({
    required this.localCustodians,
    required this.selectedCustodian,
    required this.getSeedName,
    required this.onChangedCustodian,
    super.key,
  });

  final List<PublicKey> localCustodians;
  final PublicKey? selectedCustodian;
  final String? Function(PublicKey custodian) getSeedName;
  final ValueChanged<PublicKey> onChangedCustodian;

  @override
  Widget build(BuildContext context) {
    return CommonSelectDropdown<PublicKey>(
      values: [
        for (final c in localCustodians)
          CommonSheetDropdownItem<PublicKey>(
            value: c,
            title: getSeedName(c) ?? c.toEllipseString(),
          ),
      ],
      titleText: LocaleKeys.custodianWord.tr(),
      currentValue: selectedCustodian,
      onChanged: onChangedCustodian,
    );
  }
}
