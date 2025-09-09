import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to display AddNewLocalAccountTypeSheet
ModalRoute<void> showAddNewLocalAccountTypeSheet({
  required BuildContext context,
  required PublicKey publicKey,
  required String name,
}) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.newAccountType.tr(),
    body: (_, scrollController) => AddNewLocalAccountTypeSheet(
      controller: scrollController,
      publicKey: publicKey,
      name: name,
    ),
  );
}

/// Sheet to select type of local account, that user can select for creation.
class AddNewLocalAccountTypeSheet extends InjectedElementaryParametrizedWidget<
    AddNewLocalAccountTypeSheetWidgetModel, AddNewLocalAccountTypeSheetParams> {
  AddNewLocalAccountTypeSheet({
    required this.controller,
    required PublicKey publicKey,
    required String name,
    super.key,
  }) : super(
          wmFactoryParam: AddNewLocalAccountTypeSheetParams(
            publicKey: publicKey,
            name: name,
          ),
        );

  final ScrollController controller;

  @override
  Widget build(AddNewLocalAccountTypeSheetWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.currentSelectedState,
      builder: (_, currentSelected) {
        final defaultWalletType = wm.defaultWalletType;
        final createdWalletTypes = wm.createdWalletTypes;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: controller,
                child: SeparatedColumn(
                  mainAxisSize: MainAxisSize.min,
                  separator: const Padding(
                    padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                    child: CommonDivider(),
                  ),
                  children: [
                    _Item(
                      key: ValueKey(defaultWalletType),
                      type: defaultWalletType,
                      defaultAccountName:
                          wm.defaultAccountName(defaultWalletType),
                      isSelected: currentSelected == defaultWalletType,
                      isCreated: createdWalletTypes.contains(defaultWalletType),
                      isDefault: true,
                      onChangeType: wm.changeType,
                    ),
                    ...wm.availableWalletTypes.map(
                      (WalletType type) => _Item(
                        key: ValueKey(type),
                        type: type,
                        defaultAccountName: wm.defaultAccountName(type),
                        isSelected: currentSelected == type,
                        isCreated: createdWalletTypes.contains(type),
                        onChangeType: wm.changeType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.confirm.tr(),
              onPressed: wm.createAccount,
            ),
          ],
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.type,
    required this.defaultAccountName,
    required this.isSelected,
    required this.isCreated,
    required this.onChangeType,
    this.isDefault = false,
    super.key,
  });

  final WalletType type;
  final String defaultAccountName;
  final bool isSelected;
  final bool isCreated;
  final bool isDefault;
  final ValueChanged<WalletType> onChangeType;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CommonListTile(
      height: DimensSize.d40,
      titleChild: Text(
        isDefault
            ? LocaleKeys.accountDefault.tr(args: [defaultAccountName])
            : defaultAccountName,
        style: theme.textStyles.labelMedium.copyWith(
          color: isDefault ? theme.colors.content3 : theme.colors.content0,
        ),
      ),
      onPressed: isCreated ? null : () => onChangeType(type),
      trailing: CommonRadio<WalletType>(
        value: type,
        groupValue: isCreated || isSelected ? type : null,
        enabled: !isCreated,
      ),
    );
  }
}
