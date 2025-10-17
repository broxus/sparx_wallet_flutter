import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
    ErrorHandler errorHandler,
    this.nekotonRepository,
    this.messengerService,
    this.storage,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
  final MessengerService messengerService;
  final AppStorageService storage;

  void setShowingBackUpFlag(String address) {
    final account = nekotonRepository.accountsStorage.accounts.firstWhereOrNull(
      (item) => item.address.address == address,
    );
    final masterPublicKey = account?.let(
      (account) => nekotonRepository.seedList
          .findSeedByAnyPublicKey(account.publicKey)
          ?.masterPublicKey,
    );

    if (masterPublicKey == null) return;

    storage.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      true,
    );
  }

  void showMessageAboutCopy() {
    messengerService.show(
      Message.successful(message: LocaleKeys.copiedExclamation.tr()),
    );
  }
}
