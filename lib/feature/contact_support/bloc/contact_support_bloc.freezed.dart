// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_support_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContactSupportEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ContactSupportEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ContactSupportEvent()';
  }
}

/// @nodoc
class $ContactSupportEventCopyWith<$Res> {
  $ContactSupportEventCopyWith(
      ContactSupportEvent _, $Res Function(ContactSupportEvent) __);
}

/// @nodoc

class _SendEmail implements ContactSupportEvent {
  const _SendEmail(this.mode);

  final ContactSupportMode mode;

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SendEmailCopyWith<_SendEmail> get copyWith =>
      __$SendEmailCopyWithImpl<_SendEmail>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SendEmail &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  @override
  String toString() {
    return 'ContactSupportEvent.sendEmail(mode: $mode)';
  }
}

/// @nodoc
abstract mixin class _$SendEmailCopyWith<$Res>
    implements $ContactSupportEventCopyWith<$Res> {
  factory _$SendEmailCopyWith(
          _SendEmail value, $Res Function(_SendEmail) _then) =
      __$SendEmailCopyWithImpl;
  @useResult
  $Res call({ContactSupportMode mode});
}

/// @nodoc
class __$SendEmailCopyWithImpl<$Res> implements _$SendEmailCopyWith<$Res> {
  __$SendEmailCopyWithImpl(this._self, this._then);

  final _SendEmail _self;
  final $Res Function(_SendEmail) _then;

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mode = null,
  }) {
    return _then(_SendEmail(
      null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ContactSupportMode,
    ));
  }
}

/// @nodoc

class _OpenQaScreen implements ContactSupportEvent {
  const _OpenQaScreen();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _OpenQaScreen);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ContactSupportEvent.openQaScreen()';
  }
}

/// @nodoc
mixin _$ContactSupportState {
  bool get isBusy;
  bool get isQaEnabled;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContactSupportStateCopyWith<ContactSupportState> get copyWith =>
      _$ContactSupportStateCopyWithImpl<ContactSupportState>(
          this as ContactSupportState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContactSupportState &&
            (identical(other.isBusy, isBusy) || other.isBusy == isBusy) &&
            (identical(other.isQaEnabled, isQaEnabled) ||
                other.isQaEnabled == isQaEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isBusy, isQaEnabled);

  @override
  String toString() {
    return 'ContactSupportState(isBusy: $isBusy, isQaEnabled: $isQaEnabled)';
  }
}

/// @nodoc
abstract mixin class $ContactSupportStateCopyWith<$Res> {
  factory $ContactSupportStateCopyWith(
          ContactSupportState value, $Res Function(ContactSupportState) _then) =
      _$ContactSupportStateCopyWithImpl;
  @useResult
  $Res call({bool isBusy, bool isQaEnabled});
}

/// @nodoc
class _$ContactSupportStateCopyWithImpl<$Res>
    implements $ContactSupportStateCopyWith<$Res> {
  _$ContactSupportStateCopyWithImpl(this._self, this._then);

  final ContactSupportState _self;
  final $Res Function(ContactSupportState) _then;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBusy = null,
    Object? isQaEnabled = null,
  }) {
    return _then(_self.copyWith(
      isBusy: null == isBusy
          ? _self.isBusy
          : isBusy // ignore: cast_nullable_to_non_nullable
              as bool,
      isQaEnabled: null == isQaEnabled
          ? _self.isQaEnabled
          : isQaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _ContactSupportState implements ContactSupportState {
  const _ContactSupportState({required this.isBusy, required this.isQaEnabled});

  @override
  final bool isBusy;
  @override
  final bool isQaEnabled;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContactSupportStateCopyWith<_ContactSupportState> get copyWith =>
      __$ContactSupportStateCopyWithImpl<_ContactSupportState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContactSupportState &&
            (identical(other.isBusy, isBusy) || other.isBusy == isBusy) &&
            (identical(other.isQaEnabled, isQaEnabled) ||
                other.isQaEnabled == isQaEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isBusy, isQaEnabled);

  @override
  String toString() {
    return 'ContactSupportState(isBusy: $isBusy, isQaEnabled: $isQaEnabled)';
  }
}

/// @nodoc
abstract mixin class _$ContactSupportStateCopyWith<$Res>
    implements $ContactSupportStateCopyWith<$Res> {
  factory _$ContactSupportStateCopyWith(_ContactSupportState value,
          $Res Function(_ContactSupportState) _then) =
      __$ContactSupportStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isBusy, bool isQaEnabled});
}

/// @nodoc
class __$ContactSupportStateCopyWithImpl<$Res>
    implements _$ContactSupportStateCopyWith<$Res> {
  __$ContactSupportStateCopyWithImpl(this._self, this._then);

  final _ContactSupportState _self;
  final $Res Function(_ContactSupportState) _then;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isBusy = null,
    Object? isQaEnabled = null,
  }) {
    return _then(_ContactSupportState(
      isBusy: null == isBusy
          ? _self.isBusy
          : isBusy // ignore: cast_nullable_to_non_nullable
              as bool,
      isQaEnabled: null == isQaEnabled
          ? _self.isQaEnabled
          : isQaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
