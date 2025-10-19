import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectWorkchainModel extends ElementaryModel {
  SelectWorkchainModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  Stream<Connection?> get currentConnectionStream =>
      _storageService.currentConnectionStream;

  Stream<ConnectionWorkchain?> get currentWorkchainStream =>
      _storageService.currentWorkchainStream;

  Future<void> saveCurrentConnectionId({
    required String connectionId,
    required int workchainId,
  }) {
    return _storageService.saveCurrentConnectionId(
      connectionId: connectionId,
      workchainId: workchainId,
    );
  }
}
