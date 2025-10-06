import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_token_ticker.freezed.dart';

part 'native_token_ticker.g.dart';

@freezed
abstract class NativeTokenTicker with _$NativeTokenTicker {
  const factory NativeTokenTicker({
   @Default('') String name,
  }) = _NativeTokenTicker;

  factory NativeTokenTicker.fromJson(Map<String, dynamic> json) =>
      _$NativeTokenTickerFromJson(json);
}
