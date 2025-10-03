import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditNetworkModel extends ElementaryModel {
  EditNetworkModel(
    this._connectionsStorageService,
    this._presetsConnectionService,
    this._assetsService,
    this._browserLauncher,
  );

  final ConnectionsStorageService _connectionsStorageService;
  final PresetsConnectionService _presetsConnectionService;
  final AssetsService _assetsService;
  final BrowserLauncher _browserLauncher;

  List<Connection> get connections => _connectionsStorageService.connections;

  List<NetworkType>? get networkTypesOptions =>
      _presetsConnectionService.customNetworkOptions;

  int get lastNetworkGroupNumber =>
      _connectionsStorageService.lastNetworkGroupNumber;

  void addConnection(Connection connection) =>
      _connectionsStorageService.addConnection(connection);

  void updateConnection(Connection connection) =>
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

  void openBrowserUrl(String url) => _browserLauncher.openBrowserByString(url);
}
