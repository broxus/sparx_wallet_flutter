import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/utils/json/json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connection.g.dart';

@JsonSerializable(
  createToJson: true,
  createFactory: false,
  explicitToJson: true,
)
class Connection {
  Connection({
    required String id,
    required String networkName,
    required int defaultWorkchainId,
    required List<ConnectionWorkchain> workchains,
    required bool isPreset,
    required bool canBeEdited,
  }) : this._(
         id: id,
         networkName: networkName,
         defaultWorkchainId: defaultWorkchainId,
         defaultWorkchain: workchains.firstWhere(
           (w) => w.id == defaultWorkchainId,
         ),
         workchains: workchains,
         isPreset: isPreset,
         canBeEdited: canBeEdited,
       );

  Connection._({
    required this.id,
    required this.networkName,
    required this.defaultWorkchainId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required this.defaultWorkchain,
    required this.workchains,
    required this.isPreset,
    required this.canBeEdited,
  });

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

  final String id;
  final String networkName;
  final int defaultWorkchainId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final ConnectionWorkchain defaultWorkchain;
  final List<ConnectionWorkchain> workchains;
  final bool isPreset;
  final bool canBeEdited;

  Map<String, dynamic> toJson() => _$ConnectionToJson(this);

  Connection copyWith({
    String? id,
    String? networkName,
    int? defaultWorkchainId,
    List<ConnectionWorkchain>? workchains,
    bool? isPreset,
    bool? canBeEdited,
  }) => Connection(
    id: id ?? this.id,
    networkName: networkName ?? this.networkName,
    defaultWorkchainId: defaultWorkchainId ?? this.defaultWorkchainId,
    workchains: workchains ?? this.workchains,
    isPreset: isPreset ?? this.isPreset,
    canBeEdited: canBeEdited ?? this.canBeEdited,
  );
}
