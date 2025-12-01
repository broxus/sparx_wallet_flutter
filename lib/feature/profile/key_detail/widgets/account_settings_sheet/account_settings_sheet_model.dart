import 'package:app/feature/browser/domain/browser_launcher.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class AccountSettingsSheetModel extends ElementaryModel {
  AccountSettingsSheetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._browserLauncher,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final BrowserLauncher _browserLauncher;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  void copyAddress(Address address) {
    setClipBoardData(address.address);
    _messengerService.show(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [address.toEllipseString()],
        ),
      ),
    );
  }

  void openBrowserByString(Address address) {
    _browserLauncher.openBrowserByString(
      _nekotonRepository.currentTransport.accountExplorerLink(address),
    );
  }
}
