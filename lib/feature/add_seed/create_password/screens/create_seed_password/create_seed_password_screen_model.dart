// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/constants.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [CreateSeedPasswordScreen]
@injectable
class CreateSeedPasswordScreenModel extends ElementaryModel {
  CreateSeedPasswordScreenModel(
    ErrorHandler errorHandler,
    this._biometryService,
    this._currentKeyService,
    this._currentAccountService,
    this._connectionsStorageService,
    this._messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final BiometryService _biometryService;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountService;
  final ConnectionsStorageService _connectionsStorageService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  bool get isNeedBiometry =>
      _biometryService.isAvailable && !_biometryService.isEnabled;

  Future<void> next({
    required BuildContext context,
    required String password,
    required SeedPhraseModel? phrase,
    required MnemonicType? mnemonicType,
  }) async {
    try {
      final addType = phrase != null && phrase.isNotEmpty
          ? SeedAddType.import
          : SeedAddType.create;

      final workchainId =
          _connectionsStorageService.currentConnection?.defaultWorkchainId ?? 0;

      final seed = switch (addType) {
        SeedAddType.create => _createSeed(),
        SeedAddType.import => phrase!,
      };

      final publicKey = await _nekotonRepository.addSeed(
        phrase: seed.words,
        password: password,
        workchainId: workchainId,
        mnemonicType: mnemonicType,
        addType: addType,
      );

      _currentKeyService.changeCurrentKey(publicKey);

      await _biometryService.setKeyPassword(
        publicKey: publicKey,
        password: password,
      );

      await _currentAccountService.currentActiveAccountStream.firstWhere(
        (account) => account != null,
      );
    } catch (e) {
      Logger('CreateSeedPasswordScreenModel').severe(e);
      _messengerService.show(Message.error(message: e.toString()));
    }
  }

  SeedPhraseModel _createSeed() {
    final seed = generateKey(accountType: defaultMnemonicType);
    return SeedPhraseModel.fromWords(seed.words);
  }
}
