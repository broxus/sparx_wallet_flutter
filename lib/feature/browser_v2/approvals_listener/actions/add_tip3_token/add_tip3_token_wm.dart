import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v2/approvals_listener/actions/add_tip3_token/add_tip3_token_model.dart';
import 'package:app/feature/browser_v2/approvals_listener/actions/add_tip3_token/add_tip3_token_widget.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum TokenStatus { trusted, untrasted, explicit, sameSymbol, suggestion }

class AddTip3TokenWmParams {
  const AddTip3TokenWmParams({
    required this.origin,
    required this.account,
    required this.details,
  });

  final Uri origin;
  final Address account;
  final TokenContractAsset details;
}

@injectable
class AddTip3TokenWidgetModel
    extends
        CustomWidgetModelParametrized<
          AddTip3TokenWidget,
          AddTip3TokenModel,
          AddTip3TokenWmParams
        > {
  AddTip3TokenWidgetModel(super.model);

  late final _originState = createWmParamsNotifier((it) => it.origin);

  late final _accountState = createWmParamsNotifier((it) => it.account);

  late final _detailsState = createWmParamsNotifier((it) => it.details);

  ValueListenable<Address> get accountState => _accountState;

  ValueListenable<Uri> get originState => _originState;

  ValueListenable<TokenContractAsset> get detailsState => _detailsState;

  late final _balanceState = createNotifier<Money>();
  late final _assetState = createNotifier<TokenContractAsset>();
  late final _statusState = createNotifier<TokenStatus>();
  StreamSubscription<dynamic>? _subscription;

  ListenableState<Money> get balanceState => _balanceState;

  ListenableState<TokenContractAsset> get assetState => _assetState;

  ListenableState<TokenStatus> get statusState => _statusState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _subscription = model
        .allAvailableContractsForAccount(_accountState.value)
        .listen(_onData);

    _getBalance();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onConfirm() => Navigator.of(context).pop(true);

  Future<void> _getBalance() async {
    final wallet = await model.getTokenWallet(
      owner: _accountState.value,
      rootTokenContract: _detailsState.value.address,
    );

    _balanceState.accept(wallet?.wallet?.moneyBalance);
  }

  void _onData((List<TokenContractAsset>, List<TokenContractAsset>) value) {
    final (notAdded, added) = value;
    final assets = [...notAdded, ...added];
    final address = _detailsState.value.address;
    final symbol = _detailsState.value.symbol;
    final asset = assets.firstWhereOrNull((e) => e.address == address);

    _assetState.accept(asset);

    if (asset?.isCustom == false) {
      // found trusted asset
      final hasCustom = added.any((e) => e.symbol == symbol && e.isCustom);

      if (hasCustom) {
        // has asset with the same symbol but it's custom
        _statusState.accept(TokenStatus.suggestion);
      } else {
        _statusState.accept(TokenStatus.trusted);
      }

      return;
    }

    final explicit = assets.any(
      (e) => e.symbol == symbol && !e.isCustom && e.address != address,
    );
    if (explicit) {
      // has trusted asset with the same symbol but different address
      _statusState.accept(TokenStatus.explicit);
      return;
    }

    final sameSymbol = added.any(
      (e) => e.symbol == symbol && e.address != address,
    );
    if (sameSymbol) {
      // has untrusted asset with the same symbol but different address
      _statusState.accept(TokenStatus.sameSymbol);
      return;
    }

    _statusState.accept(TokenStatus.untrasted);
  }
}
