import 'package:app/database/database_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class DatabaseConfigurator {
  DatabaseConfigurator(
    this._databaseService,
  );

  final DatabaseService _databaseService;

  Future<void> configure() async {
    _databaseService.init();
  }
}
