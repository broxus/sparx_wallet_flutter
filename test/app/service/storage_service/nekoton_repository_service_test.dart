import 'package:app/app/service/storage_service/nekoton_repository_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

void main() {
  group('NekotonRepositoryStorageService', () {
    late _MockNekotonRepository repository;
    late NekotonRepositoryStorageService service;

    setUp(() {
      repository = _MockNekotonRepository();
      service = NekotonRepositoryStorageService(repository);

      when(() => repository.clear()).thenAnswer((_) async {});
    });

    test('clear delegates to repository', () async {
      await service.clear();

      verify(() => repository.clear()).called(1);
    });

    test('init completes successfully', () async {
      await service.init();
    });
  });
}
