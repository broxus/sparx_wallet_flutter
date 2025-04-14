// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_support_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactSupportEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactSupportMode mode) sendEmail,
    required TResult Function() openQaScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactSupportMode mode)? sendEmail,
    TResult? Function()? openQaScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactSupportMode mode)? sendEmail,
    TResult Function()? openQaScreen,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendEmail value) sendEmail,
    required TResult Function(_OpenQaScreen value) openQaScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendEmail value)? sendEmail,
    TResult? Function(_OpenQaScreen value)? openQaScreen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendEmail value)? sendEmail,
    TResult Function(_OpenQaScreen value)? openQaScreen,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSupportEventCopyWith<$Res> {
  factory $ContactSupportEventCopyWith(
          ContactSupportEvent value, $Res Function(ContactSupportEvent) then) =
      _$ContactSupportEventCopyWithImpl<$Res, ContactSupportEvent>;
}

/// @nodoc
class _$ContactSupportEventCopyWithImpl<$Res, $Val extends ContactSupportEvent>
    implements $ContactSupportEventCopyWith<$Res> {
  _$ContactSupportEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SendEmailImplCopyWith<$Res> {
  factory _$$SendEmailImplCopyWith(
          _$SendEmailImpl value, $Res Function(_$SendEmailImpl) then) =
      __$$SendEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ContactSupportMode mode});
}

/// @nodoc
class __$$SendEmailImplCopyWithImpl<$Res>
    extends _$ContactSupportEventCopyWithImpl<$Res, _$SendEmailImpl>
    implements _$$SendEmailImplCopyWith<$Res> {
  __$$SendEmailImplCopyWithImpl(
      _$SendEmailImpl _value, $Res Function(_$SendEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
  }) {
    return _then(_$SendEmailImpl(
      null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as ContactSupportMode,
    ));
  }
}

/// @nodoc

class _$SendEmailImpl implements _SendEmail {
  const _$SendEmailImpl(this.mode);

  @override
  final ContactSupportMode mode;

  @override
  String toString() {
    return 'ContactSupportEvent.sendEmail(mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendEmailImpl &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mode);

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendEmailImplCopyWith<_$SendEmailImpl> get copyWith =>
      __$$SendEmailImplCopyWithImpl<_$SendEmailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactSupportMode mode) sendEmail,
    required TResult Function() openQaScreen,
  }) {
    return sendEmail(mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactSupportMode mode)? sendEmail,
    TResult? Function()? openQaScreen,
  }) {
    return sendEmail?.call(mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactSupportMode mode)? sendEmail,
    TResult Function()? openQaScreen,
    required TResult orElse(),
  }) {
    if (sendEmail != null) {
      return sendEmail(mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendEmail value) sendEmail,
    required TResult Function(_OpenQaScreen value) openQaScreen,
  }) {
    return sendEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendEmail value)? sendEmail,
    TResult? Function(_OpenQaScreen value)? openQaScreen,
  }) {
    return sendEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendEmail value)? sendEmail,
    TResult Function(_OpenQaScreen value)? openQaScreen,
    required TResult orElse(),
  }) {
    if (sendEmail != null) {
      return sendEmail(this);
    }
    return orElse();
  }
}

abstract class _SendEmail implements ContactSupportEvent {
  const factory _SendEmail(final ContactSupportMode mode) = _$SendEmailImpl;

  ContactSupportMode get mode;

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendEmailImplCopyWith<_$SendEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OpenQaScreenImplCopyWith<$Res> {
  factory _$$OpenQaScreenImplCopyWith(
          _$OpenQaScreenImpl value, $Res Function(_$OpenQaScreenImpl) then) =
      __$$OpenQaScreenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OpenQaScreenImplCopyWithImpl<$Res>
    extends _$ContactSupportEventCopyWithImpl<$Res, _$OpenQaScreenImpl>
    implements _$$OpenQaScreenImplCopyWith<$Res> {
  __$$OpenQaScreenImplCopyWithImpl(
      _$OpenQaScreenImpl _value, $Res Function(_$OpenQaScreenImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSupportEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OpenQaScreenImpl implements _OpenQaScreen {
  const _$OpenQaScreenImpl();

  @override
  String toString() {
    return 'ContactSupportEvent.openQaScreen()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OpenQaScreenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ContactSupportMode mode) sendEmail,
    required TResult Function() openQaScreen,
  }) {
    return openQaScreen();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ContactSupportMode mode)? sendEmail,
    TResult? Function()? openQaScreen,
  }) {
    return openQaScreen?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ContactSupportMode mode)? sendEmail,
    TResult Function()? openQaScreen,
    required TResult orElse(),
  }) {
    if (openQaScreen != null) {
      return openQaScreen();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SendEmail value) sendEmail,
    required TResult Function(_OpenQaScreen value) openQaScreen,
  }) {
    return openQaScreen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SendEmail value)? sendEmail,
    TResult? Function(_OpenQaScreen value)? openQaScreen,
  }) {
    return openQaScreen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SendEmail value)? sendEmail,
    TResult Function(_OpenQaScreen value)? openQaScreen,
    required TResult orElse(),
  }) {
    if (openQaScreen != null) {
      return openQaScreen(this);
    }
    return orElse();
  }
}

abstract class _OpenQaScreen implements ContactSupportEvent {
  const factory _OpenQaScreen() = _$OpenQaScreenImpl;
}

/// @nodoc
mixin _$ContactSupportState {
  bool get isBusy => throw _privateConstructorUsedError;
  bool get isQaEnabled => throw _privateConstructorUsedError;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactSupportStateCopyWith<ContactSupportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactSupportStateCopyWith<$Res> {
  factory $ContactSupportStateCopyWith(
          ContactSupportState value, $Res Function(ContactSupportState) then) =
      _$ContactSupportStateCopyWithImpl<$Res, ContactSupportState>;
  @useResult
  $Res call({bool isBusy, bool isQaEnabled});
}

/// @nodoc
class _$ContactSupportStateCopyWithImpl<$Res, $Val extends ContactSupportState>
    implements $ContactSupportStateCopyWith<$Res> {
  _$ContactSupportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBusy = null,
    Object? isQaEnabled = null,
  }) {
    return _then(_value.copyWith(
      isBusy: null == isBusy
          ? _value.isBusy
          : isBusy // ignore: cast_nullable_to_non_nullable
              as bool,
      isQaEnabled: null == isQaEnabled
          ? _value.isQaEnabled
          : isQaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactSupportStateImplCopyWith<$Res>
    implements $ContactSupportStateCopyWith<$Res> {
  factory _$$ContactSupportStateImplCopyWith(_$ContactSupportStateImpl value,
          $Res Function(_$ContactSupportStateImpl) then) =
      __$$ContactSupportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isBusy, bool isQaEnabled});
}

/// @nodoc
class __$$ContactSupportStateImplCopyWithImpl<$Res>
    extends _$ContactSupportStateCopyWithImpl<$Res, _$ContactSupportStateImpl>
    implements _$$ContactSupportStateImplCopyWith<$Res> {
  __$$ContactSupportStateImplCopyWithImpl(_$ContactSupportStateImpl _value,
      $Res Function(_$ContactSupportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isBusy = null,
    Object? isQaEnabled = null,
  }) {
    return _then(_$ContactSupportStateImpl(
      isBusy: null == isBusy
          ? _value.isBusy
          : isBusy // ignore: cast_nullable_to_non_nullable
              as bool,
      isQaEnabled: null == isQaEnabled
          ? _value.isQaEnabled
          : isQaEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ContactSupportStateImpl implements _ContactSupportState {
  const _$ContactSupportStateImpl(
      {required this.isBusy, required this.isQaEnabled});

  @override
  final bool isBusy;
  @override
  final bool isQaEnabled;

  @override
  String toString() {
    return 'ContactSupportState(isBusy: $isBusy, isQaEnabled: $isQaEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactSupportStateImpl &&
            (identical(other.isBusy, isBusy) || other.isBusy == isBusy) &&
            (identical(other.isQaEnabled, isQaEnabled) ||
                other.isQaEnabled == isQaEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isBusy, isQaEnabled);

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactSupportStateImplCopyWith<_$ContactSupportStateImpl> get copyWith =>
      __$$ContactSupportStateImplCopyWithImpl<_$ContactSupportStateImpl>(
          this, _$identity);
}

abstract class _ContactSupportState implements ContactSupportState {
  const factory _ContactSupportState(
      {required final bool isBusy,
      required final bool isQaEnabled}) = _$ContactSupportStateImpl;

  @override
  bool get isBusy;
  @override
  bool get isQaEnabled;

  /// Create a copy of ContactSupportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactSupportStateImplCopyWith<_$ContactSupportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
