// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizationEvent {
  SupportedLocaleCodes get code;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocalizationEventCopyWith<LocalizationEvent> get copyWith =>
      _$LocalizationEventCopyWithImpl<LocalizationEvent>(
          this as LocalizationEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocalizationEvent &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'LocalizationEvent(code: $code)';
  }
}

/// @nodoc
abstract mixin class $LocalizationEventCopyWith<$Res> {
  factory $LocalizationEventCopyWith(
          LocalizationEvent value, $Res Function(LocalizationEvent) _then) =
      _$LocalizationEventCopyWithImpl;
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class _$LocalizationEventCopyWithImpl<$Res>
    implements $LocalizationEventCopyWith<$Res> {
  _$LocalizationEventCopyWithImpl(this._self, this._then);

  final LocalizationEvent _self;
  final $Res Function(LocalizationEvent) _then;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocalizationEvent].
extension LocalizationEventPatterns on LocalizationEvent {
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
    TResult Function(_SetLocaleCodeFromService value)? setLocaleCodeFromService,
    TResult Function(_ChangeLocaleCode value)? changeLocaleCode,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService() when setLocaleCodeFromService != null:
        return setLocaleCodeFromService(_that);
      case _ChangeLocaleCode() when changeLocaleCode != null:
        return changeLocaleCode(_that);
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
    required TResult Function(_SetLocaleCodeFromService value)
        setLocaleCodeFromService,
    required TResult Function(_ChangeLocaleCode value) changeLocaleCode,
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService():
        return setLocaleCodeFromService(_that);
      case _ChangeLocaleCode():
        return changeLocaleCode(_that);
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
    TResult? Function(_SetLocaleCodeFromService value)?
        setLocaleCodeFromService,
    TResult? Function(_ChangeLocaleCode value)? changeLocaleCode,
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService() when setLocaleCodeFromService != null:
        return setLocaleCodeFromService(_that);
      case _ChangeLocaleCode() when changeLocaleCode != null:
        return changeLocaleCode(_that);
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
    TResult Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult Function(SupportedLocaleCodes code)? changeLocaleCode,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService() when setLocaleCodeFromService != null:
        return setLocaleCodeFromService(_that.code);
      case _ChangeLocaleCode() when changeLocaleCode != null:
        return changeLocaleCode(_that.code);
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
    required TResult Function(SupportedLocaleCodes code)
        setLocaleCodeFromService,
    required TResult Function(SupportedLocaleCodes code) changeLocaleCode,
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService():
        return setLocaleCodeFromService(_that.code);
      case _ChangeLocaleCode():
        return changeLocaleCode(_that.code);
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
    TResult? Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult? Function(SupportedLocaleCodes code)? changeLocaleCode,
  }) {
    final _that = this;
    switch (_that) {
      case _SetLocaleCodeFromService() when setLocaleCodeFromService != null:
        return setLocaleCodeFromService(_that.code);
      case _ChangeLocaleCode() when changeLocaleCode != null:
        return changeLocaleCode(_that.code);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SetLocaleCodeFromService implements LocalizationEvent {
  const _SetLocaleCodeFromService({required this.code});

  @override
  final SupportedLocaleCodes code;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SetLocaleCodeFromServiceCopyWith<_SetLocaleCodeFromService> get copyWith =>
      __$SetLocaleCodeFromServiceCopyWithImpl<_SetLocaleCodeFromService>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SetLocaleCodeFromService &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'LocalizationEvent.setLocaleCodeFromService(code: $code)';
  }
}

/// @nodoc
abstract mixin class _$SetLocaleCodeFromServiceCopyWith<$Res>
    implements $LocalizationEventCopyWith<$Res> {
  factory _$SetLocaleCodeFromServiceCopyWith(_SetLocaleCodeFromService value,
          $Res Function(_SetLocaleCodeFromService) _then) =
      __$SetLocaleCodeFromServiceCopyWithImpl;
  @override
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class __$SetLocaleCodeFromServiceCopyWithImpl<$Res>
    implements _$SetLocaleCodeFromServiceCopyWith<$Res> {
  __$SetLocaleCodeFromServiceCopyWithImpl(this._self, this._then);

  final _SetLocaleCodeFromService _self;
  final $Res Function(_SetLocaleCodeFromService) _then;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
  }) {
    return _then(_SetLocaleCodeFromService(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// @nodoc

class _ChangeLocaleCode implements LocalizationEvent {
  const _ChangeLocaleCode({required this.code});

  @override
  final SupportedLocaleCodes code;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChangeLocaleCodeCopyWith<_ChangeLocaleCode> get copyWith =>
      __$ChangeLocaleCodeCopyWithImpl<_ChangeLocaleCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChangeLocaleCode &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'LocalizationEvent.changeLocaleCode(code: $code)';
  }
}

/// @nodoc
abstract mixin class _$ChangeLocaleCodeCopyWith<$Res>
    implements $LocalizationEventCopyWith<$Res> {
  factory _$ChangeLocaleCodeCopyWith(
          _ChangeLocaleCode value, $Res Function(_ChangeLocaleCode) _then) =
      __$ChangeLocaleCodeCopyWithImpl;
  @override
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class __$ChangeLocaleCodeCopyWithImpl<$Res>
    implements _$ChangeLocaleCodeCopyWith<$Res> {
  __$ChangeLocaleCodeCopyWithImpl(this._self, this._then);

  final _ChangeLocaleCode _self;
  final $Res Function(_ChangeLocaleCode) _then;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
  }) {
    return _then(_ChangeLocaleCode(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// @nodoc
mixin _$LocalizationState {
  SupportedLocaleCodes get localeCode;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocalizationStateCopyWith<LocalizationState> get copyWith =>
      _$LocalizationStateCopyWithImpl<LocalizationState>(
          this as LocalizationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocalizationState &&
            (identical(other.localeCode, localeCode) ||
                other.localeCode == localeCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localeCode);

  @override
  String toString() {
    return 'LocalizationState(localeCode: $localeCode)';
  }
}

/// @nodoc
abstract mixin class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) _then) =
      _$LocalizationStateCopyWithImpl;
  @useResult
  $Res call({SupportedLocaleCodes localeCode});
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._self, this._then);

  final LocalizationState _self;
  final $Res Function(LocalizationState) _then;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localeCode = null,
  }) {
    return _then(_self.copyWith(
      localeCode: null == localeCode
          ? _self.localeCode
          : localeCode // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocalizationState].
extension LocalizationStatePatterns on LocalizationState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocalizationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocalizationState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_LocalizationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocalizationState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocalizationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocalizationState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(SupportedLocaleCodes localeCode)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocalizationState() when $default != null:
        return $default(_that.localeCode);
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
  TResult when<TResult extends Object?>(
    TResult Function(SupportedLocaleCodes localeCode) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocalizationState():
        return $default(_that.localeCode);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(SupportedLocaleCodes localeCode)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocalizationState() when $default != null:
        return $default(_that.localeCode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LocalizationState implements LocalizationState {
  const _LocalizationState({required this.localeCode});

  @override
  final SupportedLocaleCodes localeCode;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocalizationStateCopyWith<_LocalizationState> get copyWith =>
      __$LocalizationStateCopyWithImpl<_LocalizationState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocalizationState &&
            (identical(other.localeCode, localeCode) ||
                other.localeCode == localeCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localeCode);

  @override
  String toString() {
    return 'LocalizationState(localeCode: $localeCode)';
  }
}

/// @nodoc
abstract mixin class _$LocalizationStateCopyWith<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  factory _$LocalizationStateCopyWith(
          _LocalizationState value, $Res Function(_LocalizationState) _then) =
      __$LocalizationStateCopyWithImpl;
  @override
  @useResult
  $Res call({SupportedLocaleCodes localeCode});
}

/// @nodoc
class __$LocalizationStateCopyWithImpl<$Res>
    implements _$LocalizationStateCopyWith<$Res> {
  __$LocalizationStateCopyWithImpl(this._self, this._then);

  final _LocalizationState _self;
  final $Res Function(_LocalizationState) _then;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? localeCode = null,
  }) {
    return _then(_LocalizationState(
      localeCode: null == localeCode
          ? _self.localeCode
          : localeCode // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

// dart format on
