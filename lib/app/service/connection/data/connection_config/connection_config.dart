import 'package:app/app/service/connection/connection.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_config.freezed.dart';

part 'connection_config.g.dart';

@Freezed(fromJson: false, toJson: true)
abstract class ConnectionConfig with _$ConnectionConfig {
  factory ConnectionConfig({
    required String defaultNetworkId,
    List<ConnectionNetwork>? networks,
    List<CustomNetworkOption>? customNetworkOptions,
  }) {
    final defaultNetwork = networks?.firstWhereOrNull(
          (network) => network.id == defaultNetworkId,
        ) ??
        defaultPresetNetwork;

    return ConnectionConfig._(
      defaultNetworkId: defaultNetwork.id,
      networks: networks,
      customNetworkOptions: customNetworkOptions,
      defaultNetwork: defaultNetwork,
      customNetworkOptionTypes: customNetworkOptions == null
          ? [NetworkType.ever, NetworkType.tycho, NetworkType.custom]
          : [
              for (final option in customNetworkOptions) option.networkType,
            ],
    );
  }

  @JsonSerializable(explicitToJson: true)
  const factory ConnectionConfig._({
    required String defaultNetworkId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    required ConnectionNetwork defaultNetwork,
    List<ConnectionNetwork>? networks,
    List<CustomNetworkOption>? customNetworkOptions,
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<NetworkType>? customNetworkOptionTypes,
  }) = _ConnectionConfig;

  factory ConnectionConfig.fromJson(Map<String, dynamic> json) {
    final networks = castJsonList<dynamic>(json['networks']);

    final customNetworkOptions =
        castJsonList<dynamic>(json['customNetworkOptions']);

    return ConnectionConfig(
      defaultNetworkId: json['defaultNetworkId'] as String,
      networks: [
        for (final network in networks)
          ConnectionNetwork.fromJson(castJsonMap(network)),
      ],
      customNetworkOptions: [
        for (final option in customNetworkOptions)
          CustomNetworkOption.fromJson(castJsonMap(option)),
      ],
    );
  }
}
