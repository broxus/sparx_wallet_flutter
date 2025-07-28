part of 'export_seed_cubit.dart';

@freezed
sealed class ExportSeedState with _$ExportSeedState {
  const factory ExportSeedState.initial() = ExportSeedStateInitial;

  /// [error] that should be get from localization.
  const factory ExportSeedState.error(String error) = ExportSeedStateError;

  const factory ExportSeedState.success(List<String> phrase) =
      ExportSeedStateSuccess;
}
