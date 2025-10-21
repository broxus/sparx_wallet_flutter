import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:nekoton_webview/nekoton_webview.dart' hide Message;

const _timeLimit = Duration(seconds: 30);

@injectable
class AddNetworkModel extends ElementaryModel {
  AddNetworkModel(
    ErrorHandler errorHandler,
    this._messengerService,
    this._connectionsStorageService,
    this._connectionService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messengerService;
  final ConnectionsStorageService _connectionsStorageService;
  final ConnectionService _connectionService;
  final NekotonRepository _nekotonRepository;

  Future<Network?> addNetwork(Connection connection) async {
    Transport? transport;

    try {
      _connectionsStorageService.addConnection(connection);

      transport = await _connectionService.createTransportByWorkchain(
        connection.defaultWorkchain,
      );

      return await _connectionService
          .createStrategyByWorkchain(transport, connection.defaultWorkchain)
          .toNetwork();
    } finally {
      await transport?.dispose();
    }
  }

  Future<void> changeNetwork(String id) async {
    await _connectionsStorageService.saveCurrentConnectionId(connectionId: id);
    await _nekotonRepository.currentTransportStream
        .firstWhere((strategy) => strategy.connection?.id == id)
        .timeout(_timeLimit);
  }

  void showError(BuildContext context, String message) {
    _messengerService.show(Message.error(message: message));
  }
}
