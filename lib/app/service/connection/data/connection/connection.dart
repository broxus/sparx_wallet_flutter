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
  }) =>
      Connection._(
        id: id,
        networkName: networkName,
        defaultWorkchainId: defaultWorkchainId,
        defaultWorkchain: workchains.firstWhere(
          (w) => w.id == defaultWorkchainId,
        ),
        isPreset: isPreset,
        canBeEdited: canBeEdited,
        workchains: workchains,
      );

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

    return Connection(
      id: id,
      networkName: networkName,
      defaultWorkchainId: defaultWorkchainId,
      isPreset: (json['isPreset']) as bool? ?? true,
      canBeEdited: (json['canBeEdited']) as bool? ?? false,
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
  }) = _Connection;
}
