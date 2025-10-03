import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/utils/json/json.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection.freezed.dart';

part 'connection.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class Connection with _$Connection {
  factory Connection({
    required String id,
    required String networkName,
    required int defaultWorkchainId,
    required List<ConnectionWorkchain> workchains,
    required bool isPreset,
    required bool canBeEdited,
    required bool isUsedOnStart,
    required double sortingOrder,
  }) =>
      Connection._(
        id: id,
        networkName: networkName,
        defaultWorkchainId: defaultWorkchainId,
        defaultWorkchain: workchains.firstWhere(
          (w) => w.id == defaultWorkchainId,
        ),
        sortingOrder: sortingOrder,
        isPreset: isPreset,
        canBeEdited: canBeEdited,
        isUsedOnStart: isUsedOnStart,
        workchains: workchains,
      );

  factory Connection.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final networkName = json['networkName'] as String;

    final workchainsJson = castJsonList<Map<String, dynamic>>(
      json['workchains'],
    );

    final workchains = [
      for (final w in workchainsJson)
        ConnectionWorkchain.fromJsonCustom(
          json: w,
          parentId: id,
          networkName: networkName,
        ),
    ];

    final defaultWorkchainId = (json['defaultWorkchainId'] as num).toInt();

    return Connection(
      id: id,
      networkName: networkName,
      defaultWorkchainId: defaultWorkchainId,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isPreset: (json['isPreset']) as bool? ?? true,
      canBeEdited: (json['canBeEdited']) as bool? ?? false,
      isUsedOnStart: (json['isUsedOnStart']) as bool? ?? true,
      workchains: workchains,
    );
  }

  factory Connection._({
    required String id,
    required String networkName,
    required int defaultWorkchainId,
    required ConnectionWorkchain defaultWorkchain,
    required List<ConnectionWorkchain> workchains,
    required bool isPreset,
    required bool canBeEdited,
    required bool isUsedOnStart,
    required double sortingOrder,
  }) = _Connection;
}
