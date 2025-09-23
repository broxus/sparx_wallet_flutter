import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_native_token_option.freezed.dart';

part 'transport_native_token_option.g.dart';

@Freezed(
  unionKey: 'type',
  unionValueCase: FreezedUnionCase.none,
  fallbackUnion: 'fromConnection',
)
sealed class TransportNativeTokenTickerOption
    with _$TransportNativeTokenTickerOption {
  const factory TransportNativeTokenTickerOption.fromConnection() =
      TransportNativeTokenTickerOptionFromConnection;

  const factory TransportNativeTokenTickerOption.byName(String name) =
      TransportNativeTokenTickerOptionByName;

  factory TransportNativeTokenTickerOption.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TransportNativeTokenTickerOptionFromJson(json);
}
