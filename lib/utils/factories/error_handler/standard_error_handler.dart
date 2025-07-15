import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Customize if need
class PrimaryErrorHandler extends DefaultDebugErrorHandler {
  PrimaryErrorHandler(
    this._messengerService,
  );

  final MessengerService _messengerService;

  @override
  void handleError(Object error, {StackTrace? stackTrace}) {
    showError(error.toString());
    super.handleError(error, stackTrace: stackTrace);
  }

  void showError(
    String message, {
    Duration debounceTime = defaultInfoMessageDebounceDuration,
  }) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: debounceTime,
      ),
    );
  }
}
