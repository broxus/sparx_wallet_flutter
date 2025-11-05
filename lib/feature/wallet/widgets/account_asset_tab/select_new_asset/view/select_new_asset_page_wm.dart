import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class SelectNewAssetPageWidgetModel
    extends
        CustomWidgetModelParametrized<
          SelectNewAssetPage,
          SelectNewAssetPageModel,
          Address
        > {
  SelectNewAssetPageWidgetModel(super.model);

  late final focus = createFocusNode();

  late final _tabState = createNotifier(SelectNewAssetTabs.select);
  late final _isLoadingState = createNotifier(false);
  late final _showButtonState = createNotifier(false);
  late final _contractsState = createNotifier(<(TokenContractAsset, bool)>[]);

  StateNotifier<SelectNewAssetTabs> get tabState => _tabState;
  StateNotifier<bool> get isLoadingState => _isLoadingState;
  StateNotifier<bool> get showButtonState => _showButtonState;
  StateNotifier<List<(TokenContractAsset, bool)>> get contractsState =>
      _contractsState;

  // Internal state
  StreamSubscription<KeyAccount?>? _accountSub;
  StreamSubscription<List<(TokenContractAsset, bool)>>? _contractsSub;

  KeyAccount? _cachedAccount;
  List<(TokenContractAsset, bool)> _originalContracts = [];
  final _contractsToDisable = <Address>[];
  final _contractsToEnable = <Address>[];

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    // Account stream
    _accountSub = model.accountStreamForAddress(wmParams.value).listen((
      KeyAccount? acc,
    ) {
      _cachedAccount = acc;
      _updateState();
    });

    // Contracts stream
    _contractsSub = model.availableContractsSorted(wmParams.value).listen((
      list,
    ) {
      _originalContracts = list;
      _updateState();
    });
  }

  @override
  void dispose() {
    _accountSub?.cancel();
    _contractsSub?.cancel();
    super.dispose();
  }

  void changeTab(SelectNewAssetTabs tab) => _tabState.accept(tab);

  Future<void> enableAsset(Address address) async {
    if (_originalEnabled(address)) {
      _contractsToDisable.remove(address);
    } else {
      if (!_contractsToEnable.contains(address)) {
        _contractsToEnable.add(address);
      }
    }
    _updateState();
  }

  Future<void> disableAsset(Address address) async {
    if (_originalDisabled(address)) {
      _contractsToEnable.remove(address);
    } else {
      if (!_contractsToDisable.contains(address)) {
        _contractsToDisable.add(address);
      }
    }
    _updateState();
  }

  Future<void> addCustom(Address address) async {
    final isValid = validateAddress(address);
    final isToken = await model.getTokenContractAsset(address);
    if (isValid && isToken != null) {
      final account = _cachedAccount;
      await account?.addTokenWallet(repackAddress(address));
      _tabState.accept(SelectNewAssetTabs.select);
    } else {
      model.showInvalidRootTokenContractError();
    }
  }

  Future<void> saveChanges() async {
    _isLoadingState.accept(true);
    final account = _cachedAccount;

    if (_contractsToEnable.isNotEmpty) {
      await account?.addTokenWallets(_contractsToEnable);
    }
    if (_contractsToDisable.isNotEmpty) {
      await account?.removeTokenWallets(_contractsToDisable);
    }

    _isLoadingState.accept(false);
    await contextSafe?.compassBack();
  }

  void onInvalidPaste() => model.showInvalidRootTokenContractError();

  void onTap() => FocusScope.of(context).unfocus();

  // Helpers
  void _updateState() {
    _contractsState.accept(
      _originalContracts.map((e) => (e.$1, _contractState(e))).toList(),
    );
    _showButtonState.accept(
      _contractsToEnable.isNotEmpty || _contractsToDisable.isNotEmpty,
    );
  }

  bool _originalEnabled(Address address) =>
      _originalContracts.firstWhereOrNull((c) => c.$1.address == address)?.$2 ??
      false;

  bool _originalDisabled(Address address) =>
      !(_originalContracts
              .firstWhereOrNull((c) => c.$1.address == address)
              ?.$2 ??
          true);

  bool _contractState((TokenContractAsset, bool) pair) {
    if (pair.$2 && _contractsToDisable.contains(pair.$1.address)) return false;
    if (!pair.$2 && _contractsToEnable.contains(pair.$1.address)) return true;
    return pair.$2;
  }
}
