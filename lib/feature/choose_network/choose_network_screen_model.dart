// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/service/messenger_service.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [ChooseNetworkScreen]
class ChooseNetworkScreenModel extends ElementaryModel with ConnectionMixin {
  ChooseNetworkScreenModel(
    ErrorHandler errorHandler,
    this.messengerService,
    this.networkConnectionService,
    this._presetsConnectionService,
    this._connectionsStorageService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  @override
  @protected
  final MessengerService messengerService;

  @override
  @protected
  final NetworkConnectionService networkConnectionService;

  final PresetsConnectionService _presetsConnectionService;
  final ConnectionsStorageService _connectionsStorageService;
  final NekotonRepository _nekotonRepository;

  final connectionsState = StateNotifier<List<ChooseNetworkItemData>>(
    initValue: [],
  );

  @override
  void init() {
    _initNetworksData();
    super.init();
  }

  @override
  void dispose() {
    connectionsState.dispose();
    super.dispose();
  }

  Future<bool> selectType(BuildContext context, String id) async {
    try {
      _connectionsStorageService.saveCurrentConnectionId(id);
      await _nekotonRepository.currentTransportStream.firstWhere(
        (e) => e.connectionId == id,
      );
    } catch (e) {
      messengerService.show(
        Message.error(
          message: e.toString(),
        ),
      );
      return false;
    }

    return true;
  }

  void _initNetworksData() {
    final networks = _presetsConnectionService.networks;

    connectionsState.accept(
      [
        for (final connection in networks)
          if (connection.isUsedOnStart)
            ChooseNetworkItemData(
              id: connection.id,
              icon: _presetsConnectionService
                  .getTransportIconsByNetwork(
                    connection.group,
                  )
                  .vector,
              title: connection.name,
            ),
      ],
    );
  }
}
