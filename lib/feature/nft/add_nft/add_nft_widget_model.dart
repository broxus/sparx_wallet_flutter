import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/navigation_wm_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/nft/add_nft/add_nft_model.dart';
import 'package:app/feature/nft/add_nft/add_nft_page.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/v2/theme_style_v2.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AddNftWidgetModel defaultAddNftWidgetModelFactory(BuildContext context) {
  return AddNftWidgetModel(
    AddNftModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

class AddNftWidgetModel extends CustomWidgetModel<AddNftPage, AddNftModel>
    with NavigationMixin {
  AddNftWidgetModel(
    super.model,
  );

  late final _currentAccount = createNotifierFromStream(model.currentAccount);

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  late final addressController = createTextEditingController();

  final addressFilterFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'\s'),
  );

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  Future<void> paste() async {
    final text = await getClipBoardText();
    if (text?.isEmpty ?? true) return;

    final isValid = validateAddress(Address(address: text!));
    if (isValid) {
      addressController.text = text;
    } else {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.invalidRootTokenContract.tr(),
        ),
      );
    }
  }

  String? validateAddressField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.addressIsEmpty.tr();
    }
    /*if (_selectedAsset?.isNative != true && model.address.address == value) {
      return LocaleKeys.invalidReceiverAddress.tr();
    }*/
    return null;
  }
}
