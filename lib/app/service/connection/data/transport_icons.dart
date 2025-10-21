import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_icons.freezed.dart';

part 'transport_icons.g.dart';

@freezed
abstract class TransportIcons with _$TransportIcons {
  factory TransportIcons({
    String? nativeToken,
    String? network,
    String? vector
  }) = _TransportIcons;

  factory TransportIcons.fromJson(Map<String, dynamic> json) =>
      _$TransportIconsFromJson(json);
}
