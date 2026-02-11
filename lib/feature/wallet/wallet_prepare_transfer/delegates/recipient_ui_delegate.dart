import 'package:app/feature/qr_scanner/data/qr_scan_result.dart';
import 'package:app/feature/qr_scanner/data/qr_scan_type.dart';
import 'package:app/feature/qr_scanner/show_qr_scanner.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page_model.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

abstract interface class RecipientUi {
  abstract final TextEditingController textController;
  abstract final FocusNode focusNode;
  abstract final List<TextInputFormatter> addressFormatters;

  Future<void> onPressedScan();

  void onPressedPasteAddress(String text);

  void onPressedReceiverClear();
}

class RecipientUiDelegate implements RecipientUi {
  RecipientUiDelegate(
    this.context,
    this._model, {
    required this.checkIsValidAddress,
  });

  @override
  late final textController = TextEditingController();

  @override
  late final focusNode = FocusNode();

  @override
  final addressFormatters = [FilteringTextInputFormatter.deny(RegExp(r'\s'))];

  final BuildContext context;
  final bool Function(String? value) checkIsValidAddress;

  final WalletPrepareTransferPageModel _model;

  Address get address => Address(address: textController.text.trim());

  void init({String? address}) {
    if (address != null) textController.text = address;
  }

  void dispose() {
    textController.dispose();
    focusNode.dispose();
  }

  @override
  Future<void> onPressedScan() async {
    final result = await showQrScanner(context, types: [QrScanType.address]);

    if (!context.mounted) return;

    if (result case QrScanResultAddress(:final value)) {
      _updateText(value.address);
    } else if (result is QrScanResultInvalid) {
      _model.showError(LocaleKeys.qrScannerError.tr());
    }
  }

  @override
  void onPressedPasteAddress(String text) {
    if (text.isEmpty) {
      _model.showError(LocaleKeys.addressIsWrong.tr());
      return;
    }

    if (Address(address: text).isValid) {
      _updateText(text);
    } else {
      _model.showError(LocaleKeys.addressIsWrong.tr());
    }
  }

  @override
  void onPressedReceiverClear() => textController.clear();

  void _updateText(String text) {
    textController.text = text;
    focusNode.unfocus();
  }
}
