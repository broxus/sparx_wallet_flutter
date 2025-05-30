import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_model.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

AddNftWidgetModel defaultAddNftWidgetModelFactory(BuildContext context) {
  return AddNftWidgetModel(
    AddNftModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

class AddNftWidgetModel extends CustomWidgetModel<AddNftWidget, AddNftModel> {
  AddNftWidgetModel(super.model);

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _isLoading = createNotifier(false);
  late final _error = createNotifier<String>();

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<String> get error => _error;

  late final addressController = createTextEditingController();

  final addressFilterFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'\s'),
  );

  ThemeStyleV2 get themeStyleV2 => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    addressController.addListener(() => _error.accept(null));
  }

  String? validateAddressField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.addressIsEmpty.tr();
    }

    return null;
  }

  void onPressedClear() => addressController.clear();

  void onPressedPaste(String text) {
    if (text.isEmpty) {
      model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    if (validateAddress(Address(address: text))) {
      addressController.text = text;
    } else {
      model.showError(LocaleKeys.addressIsWrong.tr());
    }
  }

  Future<void> onPressedImport() async {
    try {
      final address = Address(address: addressController.text);

      if (!address.isValid) {
        _error.accept(LocaleKeys.invalidAddressFormat.tr());
        return;
      }

      _isLoading.accept(true);

      final collection = await model.tryGetNftCollection(address);

      if (collection == null) {
        _error.accept(LocaleKeys.nftOwnerError.tr());
        return;
      }

      contextSafe?.compassBack(collection);
    } finally {
      _isLoading.accept(false);
    }
  }
}
