import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditNetworkModel extends ElementaryModel {
  EditNetworkModel(
    this._connectionsStorageService,
    this._presetsConnectionService,
    this._assetsService,
  );

  final ConnectionsStorageService _connectionsStorageService;
  final PresetsConnectionService _presetsConnectionService;
  final AssetsService _assetsService;

  List<ConnectionData> get connections =>
      _connectionsStorageService.connections;

  List<NetworkType>? get networkTypesOptions =>
      _presetsConnectionService.customNetworkOptions;

  int get lastNetworkGroupNumber =>
      _connectionsStorageService.lastNetworkGroupNumber;

  void addConnection(ConnectionData connection) =>
      _connectionsStorageService.addConnection(connection);

  void updateConnection(ConnectionData connection) =>
      _connectionsStorageService.updateConnection(connection);

  void removeConnection(String id) =>
      _connectionsStorageService.removeConnection(id);

  void saveCurrentConnectionId(String id) =>
      _connectionsStorageService.saveCurrentConnectionId(id);

  Future<TonAssetsManifest> fetchManifest(String url) =>
      _assetsService.fetchManifest(
        manifestUrl: url,
        networkType: NetworkType.custom,
        networkGroup: 'custom',
      );
}
