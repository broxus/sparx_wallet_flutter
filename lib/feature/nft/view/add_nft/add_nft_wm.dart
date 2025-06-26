import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_model.dart';
import 'package:app/feature/nft/view/add_nft/add_nft_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class AddNftWidgetModel extends CustomWidgetModel<AddNftWidget, AddNftModel> {
  AddNftWidgetModel(super.model);

  late final _currentAccountState =
      createNotifierFromStream(model.currentAccount);
  late final _loadingState = createNotifier(false);
  late final _errorState = createNotifier<String>();

  ListenableState<KeyAccount?> get currentAccountState => _currentAccountState;

  ListenableState<bool> get loadingState => _loadingState;

  ListenableState<String> get errorState => _errorState;

  late final addressController = createTextEditingController();

  final addressFilterFormatter = [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
  ];

  ThemeStyleV2 get themeStyleV2 => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    addressController.addListener(() => _errorState.accept(null));
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
        _errorState.accept(LocaleKeys.invalidAddressFormat.tr());
        return;
      }

      _loadingState.accept(true);

      final collection = await model.tryGetNftCollection(address);

      if (collection == null) {
        _errorState.accept(LocaleKeys.nftOwnerError.tr());
        return;
      }

      contextSafe?.compassBack(collection);
    } finally {
      _loadingState.accept(false);
    }
  }
}
