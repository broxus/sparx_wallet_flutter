// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/choose_network_screen_const.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
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

  Future<bool> selectType(String id) async {
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

  List<ChooseNetworkItemData> fetchNetworksData([String? query]) {
    var networks = _startNetworks();
    if (query != null) {
      final caseSensetiveQuery = query.toLowerCase();

      networks = networks.where(
        (conntection) {
          final name = conntection.name.toLowerCase();

          return name.contains(caseSensetiveQuery);
        },
      ).toList();
    }

    return [
      for (final connection in networks)
        ChooseNetworkItemData(
          id: connection.id,
          icon: _presetsConnectionService
              .getTransportIconsByNetwork(
                connection.group,
              )
              .network,
          title: connection.name,
        ),
    ];
  }

  bool shouldShowSearch() {
    return _startNetworks().length > showSearchNetworksThreshold;
  }

  List<ConnectionData> _startNetworks() {
    return _presetsConnectionService.networks
        .where((network) => network.isUsedOnStart)
        .toList();
  }
}
