// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:flutter/cupertino.dart';

mixin ConnectionMixin {
  @protected
  abstract final MessengerService messengerService;

  @protected
  abstract final NetworkConnectionService networkConnectionService;

  Future<bool> get isConnected => networkConnectionService.isExistInternet;

  Future<bool> checkConnection() async {
    if (await isConnected) {
      return true;
    }
    messengerService.showConnectionError();
    return false;
  }
}
