import 'package:app/app/service/currency_convert_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/common.dart';

abstract interface class AmountUi {
  abstract final TextEditingController amountController;

  abstract final FocusNode amountFocus;
}

class AmountUiDelegate implements AmountUi {
  @override
  final amountController = TextEditingController();

  @override
  late final amountFocus = FocusNode();

  String get amountText => amountController.text;

  void dispose() {
    amountController.dispose();
    amountFocus.dispose();
  }

  void resetFocus() => amountFocus.requestFocus();

  Money getZeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(symbol, 0, symbol: symbol, pattern: moneyPattern(0)),
    );
  }
}
