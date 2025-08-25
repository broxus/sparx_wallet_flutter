import 'package:app/feature/profile/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'derive_keys_state.freezed.dart';

@Freezed(equal: false)
abstract class DeriveKeysState with _$DeriveKeysState {
  const factory DeriveKeysState({
    required bool canPrevPage,
    required bool canNextPage,
    required int currentPageIndex,
    required int pageCount,
    required List<DerivedKeyWithIndex> displayDerivedKeys,
    required Set<PublicKey> selectedKeys,
    required Map<PublicKey, String> keyNames,
    required bool isLoading,
    required bool isCompleted,
  }) = _DeriveKeysState;
}
