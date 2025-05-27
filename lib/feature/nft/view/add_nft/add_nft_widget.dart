import 'package:app/feature/nft/view/add_nft/add_nft_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddNftWidget extends ElementaryWidget<AddNftWidgetModel> {
  const AddNftWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddNftWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(AddNftWidgetModel wm) {
    final theme = wm.context.themeStyleV2;

    return Scaffold(
      backgroundColor: theme.colors.background0,
      appBar: DefaultAppBar(titleText: LocaleKeys.addNFT.tr()),
      body: SafeArea(
        child: StateNotifierBuilder<KeyAccount?>(
          listenableState: wm.currentAccount,
          builder: (context, account) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
              child: Column(
                children: [
                  if (account != null) AccountInfo(account: account),
                  const SizedBox(
                    height: DimensSizeV2.d12,
                  ),
                  PrimaryTextField(
                    sizeType: PrimaryTextFieldSizeType.medium,
                    hintText: "Paste NFT address",
                    textEditingController: wm.addressController,
                    inputFormatters: [wm.addressFilterFormatter],
                    validator: wm.validateAddressField,
                    suffixes: [
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: wm.addressController,
                        builder: (context, value, _) {
                          if (value.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: DimensSizeV2.d8,
                              ),
                              child: FloatButton(
                                buttonShape: ButtonShape.square,
                                buttonSize: ButtonSize.small,
                                icon: LucideIcons.arrowDownToDot,
                                onPressed: wm.paste,
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                              right: DimensSizeV2.d8,
                            ),
                            child: FloatButton(
                              buttonShape: ButtonShape.square,
                              buttonSize: ButtonSize.small,
                              icon: LucideIcons.x,
                              onPressed: () {
                                wm.addressController.clear();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  AccentButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.importWalletButtonText.tr(),
                    onPressed: () {},
                  ),
                  const SizedBox(height: DimensSizeV2.d28),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
