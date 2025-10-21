// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:app/utils/nekoton_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class CreateSeedPasswordProfileModel extends ElementaryModel
    with ConnectionMixin {
  CreateSeedPasswordProfileModel(
    ErrorHandler errorHandler,
    this.networkConnectionService,
    this.messengerService,
    this._connectionsStorageService,
    this._nekotonRepository,
    this._biometryService,
    this._storage,
  ) : super(errorHandler: errorHandler);

  @override
  final NetworkConnectionService networkConnectionService;

  @override
  final MessengerService messengerService;

  final ConnectionsStorageService _connectionsStorageService;
  final NekotonRepository _nekotonRepository;
  final BiometryService _biometryService;
  final AppStorageService _storage;

  Future<PublicKey?> addSeed({
    required BuildContext context,
    required SeedPhraseModel seedPhrase,
    required String? name,
    required String password,
    required SeedAddType type,
    required MnemonicType? mnemonicType,
    required bool isChecked,
  }) async {
    if (seedPhrase.isEmpty || !await checkConnection(context)) {
      return null;
    }

    try {
      PublicKey publicKey;
      VoidCallback? hideLoader;

      if (type == SeedAddType.import) {
        hideLoader = showLoaderScreen(
          context,
          title: LocaleKeys.scanSeedLoaderTitle.tr(),
        );
      }

      final workchainId =
          _connectionsStorageService.currentConnection?.defaultWorkchainId ?? 0;

      try {
        publicKey = await _nekotonRepository.addSeed(
          phrase: seedPhrase.words,
          password: password,
          workchainId: workchainId,
          name: name,
          addType: type,
          mnemonicType: mnemonicType,
          workchainId: 0,
        );

        if (type == SeedAddType.create && isChecked) {
          final key = StorageKey.showingManualBackupBadge(publicKey.publicKey);
          _storage.addValue(key, false);
        }

        await _nekotonRepository.seedScanCompleter(publicKey);

        await _biometryService.setKeyPassword(
          publicKey: publicKey,
          password: password,
        );
      } finally {
        hideLoader?.call();
      }

      if (type == SeedAddType.import) {
        messengerService.show(
          Message.successful(
            message: LocaleKeys.scanningCompleted.tr(),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      return publicKey;
    } catch (e, s) {
      Logger('CreateSeedPasswordProfileModel').severe(e, s);
      messengerService.show(Message.error(message: e.toString()));
      return null;
    }
  }
}
