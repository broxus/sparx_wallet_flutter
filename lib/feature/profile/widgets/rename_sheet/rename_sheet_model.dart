import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class RenameSheetModel extends ElementaryModel {
  RenameSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  String getName({
    required PublicKey publicKey,
    required bool isSeed,
  }) {
    if (isSeed) {
      final seed = _nekotonRepository.seedList.findSeed(publicKey);
      return seed?.name ?? '';
    } else {
      final key = _nekotonRepository.seedList.findSeedKey(publicKey);
      return key?.name ?? '';
    }
  }

  void rename({
    required PublicKey publicKey,
    required bool isSeed,
    required String name,
  }) {
    if (isSeed) {
      final seed = _nekotonRepository.seedList.findSeed(publicKey);
      seed?.rename(name: name);
    } else {
      final key = _nekotonRepository.seedList.findSeedKey(publicKey);
      key?.rename(name: name);
    }
  }

  void showMessage(Message message) => _messengerService.show(message);
}
