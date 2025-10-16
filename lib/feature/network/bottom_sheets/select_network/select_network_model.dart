import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectNetworkModel extends ElementaryModel {
  SelectNetworkModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  Stream<String> get currentConnectionId =>
      _storageService.currentConnectionIdStream;

  Stream<List<Connection>> get connections => _storageService.connectionsStream;

  void changeCurrentConnection(String id) {
    if (_storageService.currentConnectionId == id) return;
    _storageService.saveCurrentConnectionId(id);
  }
}
