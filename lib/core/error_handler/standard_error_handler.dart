import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@Injectable(as: ErrorHandler)
class StandardErrorHandler extends DefaultDebugErrorHandler {
  StandardErrorHandler(this._messengerService);

  final MessengerService _messengerService;

  @override
  void handleError(Object error, {StackTrace? stackTrace}) {
    showError(error);
    super.handleError(error, stackTrace: stackTrace);
  }

  void showError(
    Object messageData, {
    Duration debounceTime = defaultInfoMessageDebounceDuration,
  }) {
    _messengerService.show(
      messageData is Message
          ? messageData
          : Message.error(
              message: messageData.toString(),
              debounceTime: debounceTime,
            ),
    );
  }
}
