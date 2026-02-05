import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakePresetsConfigReader implements PresetsConfigReader {
  _FakePresetsConfigReader();

  ConnectionConfig? config;

  int calls = 0;
  PresetConfigType<dynamic>? lastType;

  @override
  Future<T?> getConfig<T>(PresetConfigType<T> configType) async {
    calls++;
    lastType = configType;
    return config as T?;
  }

  @override
  Future<void> awaitPendingUpdate<T>(PresetConfigType<T> configType) async {}
}

ConnectionConfig _makeConfig({
  required List<Connection> connections,
  required String defaultConnectionId,
  List<StartConnectionData> startConnections = const [],
  List<CustomNetworkOption> customNetworkOptions = const [],
  ConnectionDefaultSettings? defaultSettings,
}) {
  final settings =
      defaultSettings ??
      ConnectionDefaultSettings.fromJson(<String, dynamic>{
        'walletAccountNames': <String, dynamic>{},
      });

  return ConnectionConfig(
    defaultConnectionId: defaultConnectionId,
    defaultSettings: settings,
    connections: connections,
    startConnections: startConnections,
    customNetworkOptions: customNetworkOptions,
  );
}

void main() {
  group('PresetsConnectionService', () {
    test('initial state: getters return defaults / empty', () {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      expect(s.customNetworkOptions, isNull);
      expect(s.startConnections, isEmpty);
      expect(s.connections, isEmpty);
      expect(s.defaultConnection, equals(defaultPresetConnection));
      expect(s.defaultSettings, isNull);
      expect(s.currentPresetId, isNull);

      final anyGroup = defaultPresetConnection.workchains.first.networkGroup;
      expect(
        s.getTransportIconsByNetworkGroup(anyGroup),
        equals(TransportIcons()),
      );
      expect(s.getDefaultActiveAsset(anyGroup), isEmpty);
    });

    test('fetchConnectionsList: calls reader with PresetConfigType.connections '
        'and updates getters', () async {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final cfg = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
        startConnections: [
          StartConnectionData(connectionId: defaultPresetConnection.id),
        ],
      );

      reader.config = cfg;

      await s.fetchConnectionsList();

      expect(reader.calls, 1);
      expect(reader.lastType, PresetConfigType.connections);

      expect(s.connections, hasLength(1));
      expect(s.connections.single.id, defaultPresetConnection.id);

      expect(s.startConnections, hasLength(1));
      expect(
        s.startConnections.single.connectionId,
        defaultPresetConnection.id,
      );

      expect(s.defaultConnection.id, defaultPresetConnection.id);

      expect(
        s.customNetworkOptions,
        equals(const [NetworkType.ever, NetworkType.tycho, NetworkType.custom]),
      );

      expect(s.defaultSettings, isNotNull);
    });

    test('getTransportIconsByNetworkGroup: returns icons '
        'for matching workchain, else empty', () async {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final group = defaultPresetConnection.workchains.first.networkGroup;
      final expectedIcons = defaultPresetConnection.workchains.first.icons;

      reader.config = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
      );
      await s.fetchConnectionsList();

      expect(s.getTransportIconsByNetworkGroup(group), expectedIcons);

      reader.config = _makeConfig(
        connections: const [],
        defaultConnectionId: 'nope',
      );
      await s.fetchConnectionsList();

      expect(s.connections, isEmpty);
      expect(
        s.getTransportIconsByNetworkGroup(group),
        equals(TransportIcons()),
      );
    });

    test('getDefaultActiveAsset: returns assets '
        'for matching workchain, else empty', () async {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final group = defaultPresetConnection.workchains.first.networkGroup;
      final expectedAssets =
          defaultPresetConnection.workchains.first.defaultActiveAssets;

      reader.config = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
      );
      await s.fetchConnectionsList();

      expect(s.getDefaultActiveAsset(group), expectedAssets);

      reader.config = _makeConfig(
        connections: const [],
        defaultConnectionId: 'nope',
      );
      await s.fetchConnectionsList();

      expect(s.getDefaultActiveAsset(group), isEmpty);
    });

    test('fetchConnectionsList: supports null config '
        '(service falls back to defaults)', () async {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      reader.config = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
      );
      await s.fetchConnectionsList();
      expect(s.connections, isNotEmpty);

      reader.config = null;
      await s.fetchConnectionsList();

      expect(s.connections, isEmpty);
      expect(s.startConnections, isEmpty);
      expect(s.customNetworkOptions, isNull);
      expect(s.defaultConnection, equals(defaultPresetConnection));
      expect(s.defaultSettings, isNull);
    });

    test('customNetworkOptions: when customNetworkOptions provided,'
        ' types come from options list', () async {
      final reader = _FakePresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final opt1 = CustomNetworkOption.fromJson(<String, dynamic>{
        'networkType': NetworkType.ton.toJson(),
      });
      final opt2 = CustomNetworkOption.fromJson(<String, dynamic>{
        'networkType': NetworkType.venom.toJson(),
      });

      reader.config = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
        customNetworkOptions: [opt1, opt2],
      );

      await s.fetchConnectionsList();

      expect(
        s.customNetworkOptions,
        equals([NetworkType.ton, NetworkType.venom]),
      );
    });
  });
}
