import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AddressStringConverter implements JsonConverter<Address, String> {
  const AddressStringConverter();

  @override
  Address fromJson(String json) => Address.fromJson(json);

  @override
  String toJson(Address object) => object.toJson();
}

class AddressListConverter
    implements JsonConverter<List<Address>, List<dynamic>> {
  const AddressListConverter();

  @override
  List<Address> fromJson(List<dynamic> json) =>
      json.map((e) => Address.fromJson(e as String)).toList();

  @override
  List<dynamic> toJson(List<Address> object) =>
      object.map((e) => e.toJson()).toList();
}
