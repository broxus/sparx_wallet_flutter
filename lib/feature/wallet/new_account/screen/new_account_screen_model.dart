import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [NewAccountScreen]
@injectable
class NewAccountScreenModel extends ElementaryModel {
  NewAccountScreenModel(
    ErrorHandler errorHandler,
    this._messageService,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messageService;

  void showError(BuildContext context, String message) {
    _messageService.showError(context, message);
  }
}
