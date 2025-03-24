import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

TCSignDataWidgetModel defaultTCSignDataWidgetModelFactory(
  BuildContext context,
) =>
    TCSignDataWidgetModel(
      TCSignDataModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class TCSignDataWidgetModel
    extends CustomWidgetModel<TCSignDataWidget, TCSignDataModel> {
  TCSignDataWidgetModel(super.model);

  late final account = model.getAccount(widget.connection.walletAddress);

  late final _isLoading = createNotifier(true);
  late final _manifest = createNotifier<DappManifest>();

  ListenableState<bool> get isLoading => _isLoading;

  ListenableState<DappManifest> get manifest => _manifest;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _getManifest();
  }

  Future<void> onSubmit(String password) async {
    if (account == null) return;

    try {
      final result = await model.signData(
        schema: widget.payload.schema,
        cell: widget.payload.cell,
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
            context: context,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _getManifest() async {
    final manifest = await model.getManifest(widget.connection.manifestUrl);
    _manifest.accept(manifest);
  }
}
