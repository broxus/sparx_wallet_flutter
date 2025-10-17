import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/import_selected_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_token_model.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/token_data_element.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

//logic in this class was moved from check_seed_phrase_cubit.dart
@injectable
class SelectTokenWidgetModel
    extends
        CustomWidgetModelParametrized<
          SelectTokenWidget,
          SelectTokenModel,
          Address
        > {
  SelectTokenWidgetModel(super.model);

  late final _tokenContractState = createNotifier<List<TokenDataElement>>([]);
  late final _loadingState = createNotifier(true);
  late final _isAllSelectedState = createNotifier(false);

  ListenableState<List<TokenDataElement>> get tokenContractState =>
      _tokenContractState;

  ListenableState<bool> get isAllSelectedState => _isAllSelectedState;

  ListenableState<bool> get loadingState => _loadingState;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model
        .getAssets(wmParams.value)
        .listen(
          (value) {
            final data = [
              ...?_tokenContractState.value,
              for (final item in value)
                TokenDataElement(
                  asset: item.$1,
                  isSelected: false,
                  value: item.$2,
                ),
            ];
            _tokenContractState.accept(data);
          },
          onDone: () => _loadingState.accept(false),
          onError: (_) => _loadingState.accept(false),
        );
  }

  void checkTokenSelection(TokenDataElement token) {
    final updatedTokens = _tokenContractState.value?.map((entry) {
      if (entry.asset == token.asset) {
        return TokenDataElement(
          asset: entry.asset,
          isSelected: token.isSelected,
          value: entry.value,
        );
      }
      return entry;
    }).toList();
    _tokenContractState.accept(updatedTokens);
    _checkIfAllSelected();
  }

  void clickAll() {
    final allSelected = _isAllSelectedState.value ?? false;
    final updatedTokens = _tokenContractState.value?.map((entry) {
      return TokenDataElement(
        asset: entry.asset,
        isSelected: !allSelected,
        value: entry.value,
      );
    }).toList();

    _isAllSelectedState.accept(!allSelected);
    _tokenContractState.accept(updatedTokens);
  }

  Future<void> clickImport() async {
    final account = model.getAccount(wmParams.value);

    if (_tokenContractState.value != null && account != null) {
      await showImportSelectedTokensModal(context, () async {
        Navigator.of(context).pop();
        await account.addTokenWallets(
          _tokenContractState.value!
              .where((entry) => entry.isSelected)
              .map((entry) => entry.asset.address)
              .toList(),
        );
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void _checkIfAllSelected() {
    final allChecked =
        _tokenContractState.value?.every((entry) => entry.isSelected) ?? false;
    if (allChecked != _isAllSelectedState.value) {
      _isAllSelectedState.accept(allChecked);
    }
  }
}
