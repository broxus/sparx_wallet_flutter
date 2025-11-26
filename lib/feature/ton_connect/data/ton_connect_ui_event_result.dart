import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton_connect_ui_event_result.freezed.dart';

@freezed
sealed class TonConnectUiEventResult<T> with _$TonConnectUiEventResult<T> {
  const factory TonConnectUiEventResult.data({required T data}) =
      TonConnectUiEventResultData<T>;

  const factory TonConnectUiEventResult.error({
    required TonConnectException error,
  }) = TonConnectUiEventResultError;

  const factory TonConnectUiEventResult.canceled() =
      TonConnectUiEventResultCanceled;
}
