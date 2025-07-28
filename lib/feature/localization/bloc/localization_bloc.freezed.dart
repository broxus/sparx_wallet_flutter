// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
