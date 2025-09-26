import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [AccountRenameSheet]
@injectable
class AccountRenameSheetModel extends ElementaryModel {
  AccountRenameSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  String getAccountName(Address address) {
    final account = _nekotonRepository.seedList.findAccountByAddress(address);
    return account?.name ?? '';
  }

  void rename(
    Address address,
    String name,
  ) {
    final account = _nekotonRepository.seedList.findAccountByAddress(address);
    account?.rename(name);
    _messengerService.show(
      Message.successful(
        message: LocaleKeys.valueRenamed.tr(
          args: [LocaleKeys.accountWord.tr()],
        ),
      ),
    );
  }
}
