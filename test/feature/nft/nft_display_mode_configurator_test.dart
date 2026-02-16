import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/feature/nft/data/nft_display_mode.dart';
import 'package:app/feature/nft/domain/nft_display_mode_configurator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class _MockAppStorageService extends Mock implements AppStorageService {}

void main() {
  group('NftDisplayModeConfigurator', () {
    late _MockAppStorageService storage;
    late NftDisplayModeConfigurator configurator;

    setUpAll(() {
      registerFallbackValue(StorageKey.nftGridMode());
    });

    setUp(() {
      storage = _MockAppStorageService();
      configurator = NftDisplayModeConfigurator(storage);
    });

    test('displayModeStream maps stored name to enum', () async {
      // Arrange
      final subject = BehaviorSubject<String?>.seeded('grid');
      when(
        () => storage.getValueStream<String>(any()),
      ).thenAnswer((_) => subject.stream);

      // Act
      final result = await configurator.displayModeStream.first;

      // Assert
      expect(result, equals(NftDisplayMode.grid));
    });

    test('displayModeStream emits null when storage value is null', () async {
      // Arrange
      final subject = BehaviorSubject<String?>.seeded(null);
      when(
        () => storage.getValueStream<String>(any()),
      ).thenAnswer((_) => subject.stream);

      // Act
      final result = await configurator.displayModeStream.first;

      // Assert
      expect(result, isNull);
    });

    test('setDisplayMode persists selected mode name', () {
      // Arrange
      // ignore: inference_failure_on_function_invocation
      when(() => storage.addValue(any(), any())).thenAnswer((_) async {});

      // Act
      configurator.setDisplayMode(NftDisplayMode.list);

      // Assert
      verify(() => storage.addValue(any(), 'list')).called(1);
    });
  });
}
