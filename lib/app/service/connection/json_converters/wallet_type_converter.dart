import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletTypeConverter
    implements JsonConverter<WalletType, Map<String, dynamic>> {
  const WalletTypeConverter();

  @override
  WalletType fromJson(Map<String, dynamic> json) => WalletType.fromJson(json);

  @override
  Map<String, dynamic> toJson(WalletType object) => object.toJson();
}

class WalletTypeListConverter
    implements JsonConverter<List<WalletType>, List<dynamic>> {
  const WalletTypeListConverter();

  @override
  List<WalletType> fromJson(List<dynamic> json) =>
      json.map((e) => WalletType.fromJson(e as Map<String, dynamic>)).toList();

  @override
  List<dynamic> toJson(List<WalletType> object) =>
      object.map((e) => e.toJson()).toList();
}
