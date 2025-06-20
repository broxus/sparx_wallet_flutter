import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/add_tip3_token/add_tip3_token_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/add_tip3_token/add_tip3_token_widget.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum TokenStatus {
  trusted,
  untrasted,
  explicit,
  sameSymbol,
  suggestion,
}

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
    extends CustomWidgetModel<AddTip3TokenWidget, AddTip3TokenModel> {
  AddTip3TokenWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final AddTip3TokenWmParams _wmParams;

  Uri get origin => _wmParams.origin;

  Address get account => _wmParams.account;

  TokenContractAsset get details => _wmParams.details;

  late final _balance = createNotifier<Money>();
  late final _asset = createNotifier<TokenContractAsset>();
  late final _status = createNotifier<TokenStatus>();
  StreamSubscription<dynamic>? _subscription;

  ListenableState<Money> get balance => _balance;

  ListenableState<TokenContractAsset> get asset => _asset;

  ListenableState<TokenStatus> get status => _status;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _subscription = model
        .allAvailableContractsForAccount(_wmParams.account)
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
      owner: _wmParams.account,
      rootTokenContract: _wmParams.details.address,
    );

    _balance.accept(wallet?.wallet?.moneyBalance);
  }

  void _onData((List<TokenContractAsset>, List<TokenContractAsset>) value) {
    final (notAdded, added) = value;
    final assets = [...notAdded, ...added];
    final address = _wmParams.details.address;
    final symbol = _wmParams.details.symbol;
    final asset = assets.firstWhereOrNull((e) => e.address == address);

    _asset.accept(asset);

    if (asset?.isCustom == false) {
      // found trusted asset
      final hasCustom = added.any((e) => e.symbol == symbol && e.isCustom);

      if (hasCustom) {
        // has asset with the same symbol but it's custom
        _status.accept(TokenStatus.suggestion);
      } else {
        _status.accept(TokenStatus.trusted);
      }

      return;
    }

    final explicit = assets.any(
      (e) => e.symbol == symbol && !e.isCustom && e.address != address,
    );
    if (explicit) {
      // has trusted asset with the same symbol but different address
      _status.accept(TokenStatus.explicit);
      return;
    }

    final sameSymbol = added.any(
      (e) => e.symbol == symbol && e.address != address,
    );
    if (sameSymbol) {
      // has untrusted asset with the same symbol but different address
      _status.accept(TokenStatus.sameSymbol);
      return;
    }

    _status.accept(TokenStatus.untrasted);
  }
}
