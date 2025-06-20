import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class ImportWalletScreenModel extends ElementaryModel with ConnectionMixin {
  ImportWalletScreenModel(
    this.messengerService,
    this.nekotonRepository,
    this.networkConnectionService,
  );

  @override
  @protected
  final MessengerService messengerService;

  @override
  @protected
  final NetworkConnectionService networkConnectionService;

  final NekotonRepository nekotonRepository;

  String get networkGroup => nekotonRepository.currentTransport.networkGroup;

  NetworkType get networkType => nekotonRepository.currentTransport.networkType;

  void showValidateError(BuildContext context, String message) {
    messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  List<int> get allowedValues {
    try {
      return nekotonRepository.currentTransport.seedPhraseWordsCount;
    } catch (_) {
      return [];
    }
  }
}
