import 'package:app/app/service/connection/data/network_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_network_option.freezed.dart';

part 'custom_network_option.g.dart';

@freezed
abstract class CustomNetworkOption with _$CustomNetworkOption {
  factory CustomNetworkOption({required NetworkType networkType}) =
      _CustomNetworkOption;

  factory CustomNetworkOption.fromJson(Map<String, dynamic> json) =>
      _$CustomNetworkOptionFromJson(json);
}
