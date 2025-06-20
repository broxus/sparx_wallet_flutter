import 'dart:async';

import 'package:app/app/service/ton_connect/models/sign_data_payload.dart';
import 'package:app/app/service/ton_connect/models/ton_app_connection.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class TCSignDataWmParams {
  TCSignDataWmParams({
    required this.connection,
    required this.payload,
  });

  final TonAppConnection connection;
  final SignDataPayload payload;
}

@injectable
class TCSignDataWidgetModel
    extends CustomWidgetModel<TCSignDataWidget, TCSignDataModel> {
  TCSignDataWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TCSignDataWmParams _wmParams;

  TonAppConnection get connection => _wmParams.connection;

  SignDataPayload get payload => _wmParams.payload;

  late final account = model.getAccount(_wmParams.connection.walletAddress);

  late final _isLoading = createNotifier(true);

  ListenableState<bool> get isLoading => _isLoading;

  Future<void> onSubmit(String password) async {
    if (account == null) return;

    try {
      _isLoading.accept(true);

      final result = await model.signData(
        schema: _wmParams.payload.schema,
        cell: _wmParams.payload.cell,
        publicKey: account!.publicKey,
        password: password,
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
      _isLoading.accept(false);
    }
  }
}
