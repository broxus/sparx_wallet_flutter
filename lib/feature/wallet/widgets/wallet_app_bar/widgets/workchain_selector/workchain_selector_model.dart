import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/widgets/workchain_selector/workchain_selector.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [WorkchainSelector]
@injectable
class WorkchainSelectorModel extends ElementaryModel {
  WorkchainSelectorModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  Stream<Connection?> get currentConnectionStream =>
      _storageService.currentConnectionStream;

  Stream<ConnectionWorkchain?> get currentWorkchainStream =>
      _storageService.currentWorkchainStream;

  void saveCurrentConnectionId({
    required String connectionId,
    required int workchainId,
  }) =>
      _storageService.saveCurrentConnectionId(
        connectionId: connectionId,
        workchainId: workchainId,
      );
}
