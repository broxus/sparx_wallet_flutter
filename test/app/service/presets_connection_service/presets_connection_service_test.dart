import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPresetsConfigReader extends Mock implements PresetsConfigReader {}

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
      final reader = _MockPresetsConfigReader();
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
      final reader = _MockPresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final cfg = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
        startConnections: [
          StartConnectionData(connectionId: defaultPresetConnection.id),
        ],
      );

      when(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).thenAnswer((_) async => cfg);

      when(
        () => reader.awaitPendingUpdate<ConnectionConfig>(
          PresetConfigType.connections,
        ),
      ).thenAnswer((_) async {});

      await s.fetchConnectionsList();

      verify(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).called(1);

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
      final reader = _MockPresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final group = defaultPresetConnection.workchains.first.networkGroup;
      final expectedIcons = defaultPresetConnection.workchains.first.icons;

      final cfg1 = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
      );

      final cfg2 = _makeConfig(
        connections: const [],
        defaultConnectionId: 'nope',
      );

      var call = 0;
      when(() => reader.getConfig<ConnectionConfig>(PresetConfigType.connections))
          .thenAnswer((_) async {
        call++;
        return call == 1 ? cfg1 : cfg2;
      });

      when(
        () => reader.awaitPendingUpdate<ConnectionConfig>(
          PresetConfigType.connections,
        ),
      ).thenAnswer((_) async {});

      await s.fetchConnectionsList();

      expect(s.getTransportIconsByNetworkGroup(group), expectedIcons);

      await s.fetchConnectionsList();

      expect(s.connections, isEmpty);
      expect(
        s.getTransportIconsByNetworkGroup(group),
        equals(TransportIcons()),
      );

      verify(
            () =>
            reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).called(2);
    });

    test(
      'getDefaultActiveAsset: returns assets for matching workchain, else empty',
      () async {
        final reader = _MockPresetsConfigReader();
        final s = PresetsConnectionService(reader);

        final group = defaultPresetConnection.workchains.first.networkGroup;
        final expectedAssets =
            defaultPresetConnection.workchains.first.defaultActiveAssets;

        final cfg1 = _makeConfig(
          connections: [defaultPresetConnection],
          defaultConnectionId: defaultPresetConnection.id,
        );

        final cfg2 = _makeConfig(
          connections: const [],
          defaultConnectionId: 'nope',
        );

        var call = 0;
        when(
          () =>
              reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
        ).thenAnswer((_) async {
          call++;
          return call == 1 ? cfg1 : cfg2;
        });

        when(
          () => reader.awaitPendingUpdate<ConnectionConfig>(
            PresetConfigType.connections,
          ),
        ).thenAnswer((_) async {});

        await s.fetchConnectionsList();

        expect(s.getDefaultActiveAsset(group), expectedAssets);

        await s.fetchConnectionsList();

        expect(s.getDefaultActiveAsset(group), isEmpty);

        verify(
          () =>
              reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
        ).called(2);
      },
    );

    test('fetchConnectionsList: supports null config '
        '(service falls back to defaults)', () async {
      final reader = _MockPresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final cfg = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
      );

      var call = 0;
      when(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).thenAnswer((_) async {
        call++;
        return call == 1 ? cfg : null;
      });

      when(
        () => reader.awaitPendingUpdate<ConnectionConfig>(
          PresetConfigType.connections,
        ),
      ).thenAnswer((_) async {});

      await s.fetchConnectionsList();

      expect(s.connections, isNotEmpty);

      await s.fetchConnectionsList();

      expect(s.connections, isEmpty);
      expect(s.startConnections, isEmpty);
      expect(s.customNetworkOptions, isNull);
      expect(s.defaultConnection, equals(defaultPresetConnection));
      expect(s.defaultSettings, isNull);

      verify(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).called(2);
    });

    test('customNetworkOptions: when customNetworkOptions provided, '
        'types come from options list', () async {
      final reader = _MockPresetsConfigReader();
      final s = PresetsConnectionService(reader);

      final opt1 = CustomNetworkOption.fromJson(<String, dynamic>{
        'networkType': NetworkType.ton.toJson(),
      });
      final opt2 = CustomNetworkOption.fromJson(<String, dynamic>{
        'networkType': NetworkType.venom.toJson(),
      });

      final cfg = _makeConfig(
        connections: [defaultPresetConnection],
        defaultConnectionId: defaultPresetConnection.id,
        customNetworkOptions: [opt1, opt2],
      );

      when(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).thenAnswer((_) async => cfg);

      when(
        () => reader.awaitPendingUpdate<ConnectionConfig>(
          PresetConfigType.connections,
        ),
      ).thenAnswer((_) async {});

      await s.fetchConnectionsList();

      expect(
        s.customNetworkOptions,
        equals([NetworkType.ton, NetworkType.venom]),
      );

      verify(
        () => reader.getConfig<ConnectionConfig>(PresetConfigType.connections),
      ).called(1);
    });
  });
}
