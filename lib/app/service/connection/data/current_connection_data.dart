import 'package:app/app/service/connection/data/connection_network/connection_network.dart';
import 'package:app/app/service/connection/data/custom_network/custom_network_option.dart';
import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/default_network.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_connection_data.freezed.dart';

part 'current_connection_data.g.dart';

@freezed
abstract class CurrentConnectionData with _$CurrentConnectionData {
  factory CurrentConnectionData({
    required String networkId,
    required int workchainId,
  }) = _CurrentConnectionData;

  factory CurrentConnectionData.fromJson(Map<String, dynamic> json) =>
      _$CurrentConnectionDataFromJson(json);
}
