part of 'create_seed_cubit.dart';

@freezed
sealed class CreateSeedCubitState with _$CreateSeedCubitState {
  const factory CreateSeedCubitState.initial() = CreateSeedCubitStateInitial;

  const factory CreateSeedCubitState.generated({
    required SeedPhraseModel seed,
    required bool isCopied,
  }) = CreateSeedCubitStateGenerated;
}
