import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show SignInputAuth, SignInputAuthLedger;
import 'package:nekoton_repository/nekoton_repository.dart' show KeyAccount;

class TCSignDataWmParams {
  TCSignDataWmParams({
    required this.connection,
    required this.payload,
  });

  final TonAppConnection connection;
  final SignDataPayload payload;
}

@injectable
class TCSignDataWidgetModel extends CustomWidgetModelParametrized<
    TCSignDataWidget, TCSignDataModel, TCSignDataWmParams> {
  TCSignDataWidgetModel(
    super.model,
  );

  late final _connectionState = createWmParamsNotifier((it) => it.connection);
  late final _payloadState = createWmParamsNotifier((it) => it.payload);

  ValueListenable<TonAppConnection> get connectionState => _connectionState;
  ValueListenable<SignDataPayload> get payloadState => _payloadState;

  late final ValueListenable<KeyAccount?> accountState = createWmParamsNotifier(
    (it) => model.getAccount(it.connection.walletAddress),
  );

  late final _isLoadingState = createNotifier(true);

  ListenableState<bool> get isLoadingState => _isLoadingState;

  Future<void> onSubmit(SignInputAuth signInputAuth) async {
    final account = accountState.value;
    if (account == null) return;

    try {
      _isLoadingState.accept(true);

      final result = await model.signData(
        schema: wmParams.value.payload.schema,
        cell: wmParams.value.payload.cell,
        publicKey: account.publicKey,
        signInputAuth: signInputAuth,
      );

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop(result);
      }
    } catch (e) {
      contextSafe?.let(
        (context) => model.showMessage(
          Message.error(
            message: e.toString(),
          ),
        ),
      );
    } finally {
      _isLoadingState.accept(false);
    }
  }

  SignInputAuthLedger getLedgerAuthInput() {
    final account = accountState.value;
    if (account == null) throw StateError('Account is not initialized');

    return SignInputAuthLedger(
      wallet: account.account.tonWallet.contract,
    );
  }
}
