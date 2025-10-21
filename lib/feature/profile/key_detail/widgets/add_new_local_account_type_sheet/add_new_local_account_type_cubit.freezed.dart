// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_new_local_account_type_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddNewLocalAccountTypeState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddNewLocalAccountTypeState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddNewLocalAccountTypeState()';
  }
}

/// @nodoc
class $AddNewLocalAccountTypeStateCopyWith<$Res> {
  $AddNewLocalAccountTypeStateCopyWith(AddNewLocalAccountTypeState _,
      $Res Function(AddNewLocalAccountTypeState) __);
}

/// Adds pattern-matching-related methods to [AddNewLocalAccountTypeState].
extension AddNewLocalAccountTypeStatePatterns on AddNewLocalAccountTypeState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddNewLocalAccountTypeStateInitial value)? initial,
    TResult Function(AddNewLocalAccountTypeStateData value)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial() when initial != null:
        return initial(_that);
      case AddNewLocalAccountTypeStateData() when data != null:
        return data(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddNewLocalAccountTypeStateInitial value) initial,
    required TResult Function(AddNewLocalAccountTypeStateData value) data,
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial():
        return initial(_that);
      case AddNewLocalAccountTypeStateData():
        return data(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddNewLocalAccountTypeStateInitial value)? initial,
    TResult? Function(AddNewLocalAccountTypeStateData value)? data,
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial() when initial != null:
        return initial(_that);
      case AddNewLocalAccountTypeStateData() when data != null:
        return data(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            List<WalletType> availableAccounts,
            WalletType defaultAccount,
            List<WalletType> createdAccounts,
            WalletType? currentSelected,
            bool isCompleted)?
        data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial() when initial != null:
        return initial();
      case AddNewLocalAccountTypeStateData() when data != null:
        return data(_that.availableAccounts, _that.defaultAccount,
            _that.createdAccounts, _that.currentSelected, _that.isCompleted);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            List<WalletType> availableAccounts,
            WalletType defaultAccount,
            List<WalletType> createdAccounts,
            WalletType? currentSelected,
            bool isCompleted)
        data,
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial():
        return initial();
      case AddNewLocalAccountTypeStateData():
        return data(_that.availableAccounts, _that.defaultAccount,
            _that.createdAccounts, _that.currentSelected, _that.isCompleted);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            List<WalletType> availableAccounts,
            WalletType defaultAccount,
            List<WalletType> createdAccounts,
            WalletType? currentSelected,
            bool isCompleted)?
        data,
  }) {
    final _that = this;
    switch (_that) {
      case AddNewLocalAccountTypeStateInitial() when initial != null:
        return initial();
      case AddNewLocalAccountTypeStateData() when data != null:
        return data(_that.availableAccounts, _that.defaultAccount,
            _that.createdAccounts, _that.currentSelected, _that.isCompleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AddNewLocalAccountTypeStateInitial
    implements AddNewLocalAccountTypeState {
  const AddNewLocalAccountTypeStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddNewLocalAccountTypeStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddNewLocalAccountTypeState.initial()';
  }
}

/// @nodoc

class AddNewLocalAccountTypeStateData implements AddNewLocalAccountTypeState {
  const AddNewLocalAccountTypeStateData(
      {required final List<WalletType> availableAccounts,
      required this.defaultAccount,
      required final List<WalletType> createdAccounts,
      required this.currentSelected,
      required this.isCompleted})
      : _availableAccounts = availableAccounts,
        _createdAccounts = createdAccounts;

  final List<WalletType> _availableAccounts;
  List<WalletType> get availableAccounts {
    if (_availableAccounts is EqualUnmodifiableListView)
      return _availableAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAccounts);
  }

  final WalletType defaultAccount;
  final List<WalletType> _createdAccounts;
  List<WalletType> get createdAccounts {
    if (_createdAccounts is EqualUnmodifiableListView) return _createdAccounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_createdAccounts);
  }

  final WalletType? currentSelected;
  final bool isCompleted;

  /// Create a copy of AddNewLocalAccountTypeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddNewLocalAccountTypeStateDataCopyWith<AddNewLocalAccountTypeStateData>
      get copyWith => _$AddNewLocalAccountTypeStateDataCopyWithImpl<
          AddNewLocalAccountTypeStateData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddNewLocalAccountTypeStateData &&
            const DeepCollectionEquality()
                .equals(other._availableAccounts, _availableAccounts) &&
            (identical(other.defaultAccount, defaultAccount) ||
                other.defaultAccount == defaultAccount) &&
            const DeepCollectionEquality()
                .equals(other._createdAccounts, _createdAccounts) &&
            (identical(other.currentSelected, currentSelected) ||
                other.currentSelected == currentSelected) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableAccounts),
      defaultAccount,
      const DeepCollectionEquality().hash(_createdAccounts),
      currentSelected,
      isCompleted);

  @override
  String toString() {
    return 'AddNewLocalAccountTypeState.data(availableAccounts: $availableAccounts, defaultAccount: $defaultAccount, createdAccounts: $createdAccounts, currentSelected: $currentSelected, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $AddNewLocalAccountTypeStateDataCopyWith<$Res>
    implements $AddNewLocalAccountTypeStateCopyWith<$Res> {
  factory $AddNewLocalAccountTypeStateDataCopyWith(
          AddNewLocalAccountTypeStateData value,
          $Res Function(AddNewLocalAccountTypeStateData) _then) =
      _$AddNewLocalAccountTypeStateDataCopyWithImpl;
  @useResult
  $Res call(
      {List<WalletType> availableAccounts,
      WalletType defaultAccount,
      List<WalletType> createdAccounts,
      WalletType? currentSelected,
      bool isCompleted});

  $WalletTypeCopyWith<$Res> get defaultAccount;
  $WalletTypeCopyWith<$Res>? get currentSelected;
}

/// @nodoc
class _$AddNewLocalAccountTypeStateDataCopyWithImpl<$Res>
    implements $AddNewLocalAccountTypeStateDataCopyWith<$Res> {
  _$AddNewLocalAccountTypeStateDataCopyWithImpl(this._self, this._then);

  final AddNewLocalAccountTypeStateData _self;
  final $Res Function(AddNewLocalAccountTypeStateData) _then;

  /// Create a copy of AddNewLocalAccountTypeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableAccounts = null,
    Object? defaultAccount = null,
    Object? createdAccounts = null,
    Object? currentSelected = freezed,
    Object? isCompleted = null,
  }) {
    return _then(AddNewLocalAccountTypeStateData(
      availableAccounts: null == availableAccounts
          ? _self._availableAccounts
          : availableAccounts // ignore: cast_nullable_to_non_nullable
              as List<WalletType>,
      defaultAccount: null == defaultAccount
          ? _self.defaultAccount
          : defaultAccount // ignore: cast_nullable_to_non_nullable
              as WalletType,
      createdAccounts: null == createdAccounts
          ? _self._createdAccounts
          : createdAccounts // ignore: cast_nullable_to_non_nullable
              as List<WalletType>,
      currentSelected: freezed == currentSelected
          ? _self.currentSelected
          : currentSelected // ignore: cast_nullable_to_non_nullable
              as WalletType?,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AddNewLocalAccountTypeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res> get defaultAccount {
    return $WalletTypeCopyWith<$Res>(_self.defaultAccount, (value) {
      return _then(_self.copyWith(defaultAccount: value));
    });
  }

  /// Create a copy of AddNewLocalAccountTypeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res>? get currentSelected {
    if (_self.currentSelected == null) {
      return null;
    }

    return $WalletTypeCopyWith<$Res>(_self.currentSelected!, (value) {
      return _then(_self.copyWith(currentSelected: value));
    });
  }
}

// dart format on
