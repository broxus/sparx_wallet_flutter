import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class TCManageDappsModel extends ElementaryModel {
  TCManageDappsModel(
    ErrorHandler errorHandler,
    this._tonConnectService,
    this._tonConnectStorageService,
    this._tonConnectHttpBridge,
  ) : super(errorHandler: errorHandler);

  final TonConnectService _tonConnectService;
  final TonConnectStorageService _tonConnectStorageService;
  final TonConnectHttpBridge _tonConnectHttpBridge;

  Stream<List<TonAppConnection>> get connections => _tonConnectStorageService
      .connectionsStream
      .map((connections) => connections.sortedBy((e) => e.manifest.name));

  void disconnect(TonAppConnection connection) {
    if (connection is TonAppConnectionRemote) {
      _tonConnectHttpBridge.disconnect(connection: connection);
    } else {
      _tonConnectService.disconnect(connection: connection);
    }
  }

  void disconnectAll() {
    final connections = _tonConnectStorageService.readConnections();

    for (final connection in connections) {
      disconnect(connection);
    }
  }
}
