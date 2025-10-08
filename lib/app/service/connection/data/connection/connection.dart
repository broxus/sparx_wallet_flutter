import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/utils/json/json.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class Connection with _$Connection {
  factory Connection({
    required String id,
    required String networkName,
    required ConnectionWorkchain defaultWorkchain,
    required ConnectionWorkchain currentWorkchain,
    required List<ConnectionWorkchain> workchains,
    required bool isPreset,
    required bool canBeEdited,
    required bool isUsedOnStart,
    required double sortingOrder,
  }) = _Connection;

  factory Connection.fromJson({
    required Map<String, dynamic> json,
    required Map<String, dynamic> commonWalletDefaultAccountNames,
  }) {
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
          commonWalletDefaultAccountNames: commonWalletDefaultAccountNames,
        ),
    ];

    final defaultWorkchainId = (json['defaultWorkchainId'] as num).toInt();

    final defaultWorkchain =
        workchains.firstWhereOrNull((w) => w.id == defaultWorkchainId) ??
            workchains.first;

    return Connection(
      id: id,
      networkName: networkName,
      defaultWorkchain: defaultWorkchain,
      currentWorkchain: defaultWorkchain,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
      isPreset: (json['isPreset']) as bool? ?? true,
      canBeEdited: (json['canBeEdited']) as bool? ?? false,
      isUsedOnStart: (json['isUsedOnStart']) as bool? ?? true,
      workchains: workchains,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'networkName': networkName,
        'defaultWorkchainId': defaultWorkchain.id,
        'workchains': workchains.map((e) => e.toJson()).toList(),
        'isPreset': isPreset,
        'canBeEdited': canBeEdited,
        'isUsedOnStart': isUsedOnStart,
        'sortingOrder': sortingOrder,
      };
}

extension ConnectionExt on Connection {
  int get currentWorkchainId => currentWorkchain.id;

  int get defaultWorkchainId => defaultWorkchain.id;
}
