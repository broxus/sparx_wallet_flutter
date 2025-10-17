import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class DeleteAccountSheetModel extends ElementaryModel {
  DeleteAccountSheetModel({
    required ErrorHandler errorHandler,
    required this.balanceService,
    required this.convertService,
  }) : super(errorHandler: errorHandler);

  final BalanceService balanceService;
  final CurrencyConvertService convertService;

  Stream<Money?> accountOverallBalance(Address address) => balanceService
      .accountOverallBalance(address)
      .map((fixed) => fixed != null ? convertService.convert(fixed) : null);
}
