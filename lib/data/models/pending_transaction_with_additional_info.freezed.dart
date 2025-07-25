// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_transaction_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendingTransactionWithAdditionalInfo {
  PendingTransaction get transaction;
  @amountJsonConverter
  BigInt? get amount;
  int get createdAt;
  String? get dst;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PendingTransactionWithAdditionalInfoCopyWith<
          PendingTransactionWithAdditionalInfo>
      get copyWith => _$PendingTransactionWithAdditionalInfoCopyWithImpl<
              PendingTransactionWithAdditionalInfo>(
          this as PendingTransactionWithAdditionalInfo, _$identity);

  /// Serializes this PendingTransactionWithAdditionalInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PendingTransactionWithAdditionalInfo &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dst, dst) || other.dst == dst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transaction, amount, createdAt, dst);

  @override
  String toString() {
    return 'PendingTransactionWithAdditionalInfo(transaction: $transaction, amount: $amount, createdAt: $createdAt, dst: $dst)';
  }
}

/// @nodoc
abstract mixin class $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  factory $PendingTransactionWithAdditionalInfoCopyWith(
          PendingTransactionWithAdditionalInfo value,
          $Res Function(PendingTransactionWithAdditionalInfo) _then) =
      _$PendingTransactionWithAdditionalInfoCopyWithImpl;
  @useResult
  $Res call(
      {PendingTransaction transaction,
      @amountJsonConverter BigInt? amount,
      int createdAt,
      String? dst});

  $PendingTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class _$PendingTransactionWithAdditionalInfoCopyWithImpl<$Res>
    implements $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  _$PendingTransactionWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final PendingTransactionWithAdditionalInfo _self;
  final $Res Function(PendingTransactionWithAdditionalInfo) _then;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? amount = freezed,
    Object? createdAt = null,
    Object? dst = freezed,
  }) {
    return _then(_self.copyWith(
      transaction: null == transaction
          ? _self.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as PendingTransaction,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      dst: freezed == dst
          ? _self.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PendingTransactionCopyWith<$Res> get transaction {
    return $PendingTransactionCopyWith<$Res>(_self.transaction, (value) {
      return _then(_self.copyWith(transaction: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PendingTransactionWithAdditionalInfo
    extends PendingTransactionWithAdditionalInfo {
  const _PendingTransactionWithAdditionalInfo(
      {required this.transaction,
      @amountJsonConverter required this.amount,
      required this.createdAt,
      this.dst})
      : super._();
  factory _PendingTransactionWithAdditionalInfo.fromJson(
          Map<String, dynamic> json) =>
      _$PendingTransactionWithAdditionalInfoFromJson(json);

  @override
  final PendingTransaction transaction;
  @override
  @amountJsonConverter
  final BigInt? amount;
  @override
  final int createdAt;
  @override
  final String? dst;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PendingTransactionWithAdditionalInfoCopyWith<
          _PendingTransactionWithAdditionalInfo>
      get copyWith => __$PendingTransactionWithAdditionalInfoCopyWithImpl<
          _PendingTransactionWithAdditionalInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PendingTransactionWithAdditionalInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PendingTransactionWithAdditionalInfo &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dst, dst) || other.dst == dst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transaction, amount, createdAt, dst);

  @override
  String toString() {
    return 'PendingTransactionWithAdditionalInfo(transaction: $transaction, amount: $amount, createdAt: $createdAt, dst: $dst)';
  }
}

/// @nodoc
abstract mixin class _$PendingTransactionWithAdditionalInfoCopyWith<$Res>
    implements $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  factory _$PendingTransactionWithAdditionalInfoCopyWith(
          _PendingTransactionWithAdditionalInfo value,
          $Res Function(_PendingTransactionWithAdditionalInfo) _then) =
      __$PendingTransactionWithAdditionalInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PendingTransaction transaction,
      @amountJsonConverter BigInt? amount,
      int createdAt,
      String? dst});

  @override
  $PendingTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$PendingTransactionWithAdditionalInfoCopyWithImpl<$Res>
    implements _$PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  __$PendingTransactionWithAdditionalInfoCopyWithImpl(this._self, this._then);

  final _PendingTransactionWithAdditionalInfo _self;
  final $Res Function(_PendingTransactionWithAdditionalInfo) _then;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? transaction = null,
    Object? amount = freezed,
    Object? createdAt = null,
    Object? dst = freezed,
  }) {
    return _then(_PendingTransactionWithAdditionalInfo(
      transaction: null == transaction
          ? _self.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as PendingTransaction,
      amount: freezed == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      dst: freezed == dst
          ? _self.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PendingTransactionCopyWith<$Res> get transaction {
    return $PendingTransactionCopyWith<$Res>(_self.transaction, (value) {
      return _then(_self.copyWith(transaction: value));
    });
  }
}

// dart format on
