import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

const _timeLimit = Duration(seconds: 30);

@injectable
class ChangeNetworkModel extends ElementaryModel {
  ChangeNetworkModel(
    ErrorHandler errorHandler,
    this._messengerService,
    this._connectionsStorageService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messengerService;
  final ConnectionsStorageService _connectionsStorageService;
  final NekotonRepository _nekotonRepository;

  Future<TransportStrategy> changeConnection(String id) async {
    _connectionsStorageService.saveCurrentConnectionId(id);
    return _nekotonRepository.currentTransportStream
        .firstWhere(
          (strategy) => strategy.connection?.id == id,
        )
        .timeout(_timeLimit);
  }

  void showError(BuildContext context, String message) {
    _messengerService.show(
      Message.error(message: message),
    );
  }
}
