// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_seed_phrase_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckSeedPhraseCubitState implements DiagnosticableTreeMixin {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties..add(DiagnosticsProperty('type', 'CheckSeedPhraseCubitState'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckSeedPhraseCubitState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckSeedPhraseCubitState()';
  }
}

/// @nodoc
class $CheckSeedPhraseCubitStateCopyWith<$Res> {
  $CheckSeedPhraseCubitStateCopyWith(
      CheckSeedPhraseCubitState _, $Res Function(CheckSeedPhraseCubitState) __);
}

/// Adds pattern-matching-related methods to [CheckSeedPhraseCubitState].
extension CheckSeedPhraseCubitStatePatterns on CheckSeedPhraseCubitState {
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
    TResult Function(CheckSeedPhraseCubitStateInitial value)? initial,
    TResult Function(CheckSeedPhraseCubitStateAnswer value)? answer,
    TResult Function(CheckSeedPhraseCubitStateCorrect value)? correct,
    TResult Function(CheckSeedPhraseCubitStateError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial() when initial != null:
        return initial(_that);
      case CheckSeedPhraseCubitStateAnswer() when answer != null:
        return answer(_that);
      case CheckSeedPhraseCubitStateCorrect() when correct != null:
        return correct(_that);
      case CheckSeedPhraseCubitStateError() when error != null:
        return error(_that);
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
    required TResult Function(CheckSeedPhraseCubitStateInitial value) initial,
    required TResult Function(CheckSeedPhraseCubitStateAnswer value) answer,
    required TResult Function(CheckSeedPhraseCubitStateCorrect value) correct,
    required TResult Function(CheckSeedPhraseCubitStateError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial():
        return initial(_that);
      case CheckSeedPhraseCubitStateAnswer():
        return answer(_that);
      case CheckSeedPhraseCubitStateCorrect():
        return correct(_that);
      case CheckSeedPhraseCubitStateError():
        return error(_that);
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
    TResult? Function(CheckSeedPhraseCubitStateInitial value)? initial,
    TResult? Function(CheckSeedPhraseCubitStateAnswer value)? answer,
    TResult? Function(CheckSeedPhraseCubitStateCorrect value)? correct,
    TResult? Function(CheckSeedPhraseCubitStateError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial() when initial != null:
        return initial(_that);
      case CheckSeedPhraseCubitStateAnswer() when answer != null:
        return answer(_that);
      case CheckSeedPhraseCubitStateCorrect() when correct != null:
        return correct(_that);
      case CheckSeedPhraseCubitStateError() when error != null:
        return error(_that);
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
    TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers, int currentAnswerIndex)?
        answer,
    TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)?
        correct,
    TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)?
        error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial() when initial != null:
        return initial();
      case CheckSeedPhraseCubitStateAnswer() when answer != null:
        return answer(_that.availableAnswers, _that.userAnswers,
            _that.currentAnswerIndex);
      case CheckSeedPhraseCubitStateCorrect() when correct != null:
        return correct(_that.availableAnswers, _that.userAnswers);
      case CheckSeedPhraseCubitStateError() when error != null:
        return error(_that.availableAnswers, _that.userAnswers);
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
    required TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers, int currentAnswerIndex)
        answer,
    required TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)
        correct,
    required TResult Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)
        error,
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial():
        return initial();
      case CheckSeedPhraseCubitStateAnswer():
        return answer(_that.availableAnswers, _that.userAnswers,
            _that.currentAnswerIndex);
      case CheckSeedPhraseCubitStateCorrect():
        return correct(_that.availableAnswers, _that.userAnswers);
      case CheckSeedPhraseCubitStateError():
        return error(_that.availableAnswers, _that.userAnswers);
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
    TResult? Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers, int currentAnswerIndex)?
        answer,
    TResult? Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)?
        correct,
    TResult? Function(List<String> availableAnswers,
            List<CheckSeedCorrectAnswer> userAnswers)?
        error,
  }) {
    final _that = this;
    switch (_that) {
      case CheckSeedPhraseCubitStateInitial() when initial != null:
        return initial();
      case CheckSeedPhraseCubitStateAnswer() when answer != null:
        return answer(_that.availableAnswers, _that.userAnswers,
            _that.currentAnswerIndex);
      case CheckSeedPhraseCubitStateCorrect() when correct != null:
        return correct(_that.availableAnswers, _that.userAnswers);
      case CheckSeedPhraseCubitStateError() when error != null:
        return error(_that.availableAnswers, _that.userAnswers);
      case _:
        return null;
    }
  }
}

/// @nodoc

class CheckSeedPhraseCubitStateInitial
    with DiagnosticableTreeMixin
    implements CheckSeedPhraseCubitState {
  const CheckSeedPhraseCubitStateInitial();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CheckSeedPhraseCubitState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckSeedPhraseCubitStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckSeedPhraseCubitState.initial()';
  }
}

/// @nodoc

class CheckSeedPhraseCubitStateAnswer
    with DiagnosticableTreeMixin
    implements CheckSeedPhraseCubitState {
  const CheckSeedPhraseCubitStateAnswer(final List<String> availableAnswers,
      final List<CheckSeedCorrectAnswer> userAnswers, this.currentAnswerIndex)
      : _availableAnswers = availableAnswers,
        _userAnswers = userAnswers;

  final List<String> _availableAnswers;
  List<String> get availableAnswers {
    if (_availableAnswers is EqualUnmodifiableListView)
      return _availableAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAnswers);
  }

  final List<CheckSeedCorrectAnswer> _userAnswers;
  List<CheckSeedCorrectAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  final int currentAnswerIndex;

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckSeedPhraseCubitStateAnswerCopyWith<CheckSeedPhraseCubitStateAnswer>
      get copyWith => _$CheckSeedPhraseCubitStateAnswerCopyWithImpl<
          CheckSeedPhraseCubitStateAnswer>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CheckSeedPhraseCubitState.answer'))
      ..add(DiagnosticsProperty('availableAnswers', availableAnswers))
      ..add(DiagnosticsProperty('userAnswers', userAnswers))
      ..add(DiagnosticsProperty('currentAnswerIndex', currentAnswerIndex));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckSeedPhraseCubitStateAnswer &&
            const DeepCollectionEquality()
                .equals(other._availableAnswers, _availableAnswers) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.currentAnswerIndex, currentAnswerIndex) ||
                other.currentAnswerIndex == currentAnswerIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableAnswers),
      const DeepCollectionEquality().hash(_userAnswers),
      currentAnswerIndex);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckSeedPhraseCubitState.answer(availableAnswers: $availableAnswers, userAnswers: $userAnswers, currentAnswerIndex: $currentAnswerIndex)';
  }
}

/// @nodoc
abstract mixin class $CheckSeedPhraseCubitStateAnswerCopyWith<$Res>
    implements $CheckSeedPhraseCubitStateCopyWith<$Res> {
  factory $CheckSeedPhraseCubitStateAnswerCopyWith(
          CheckSeedPhraseCubitStateAnswer value,
          $Res Function(CheckSeedPhraseCubitStateAnswer) _then) =
      _$CheckSeedPhraseCubitStateAnswerCopyWithImpl;
  @useResult
  $Res call(
      {List<String> availableAnswers,
      List<CheckSeedCorrectAnswer> userAnswers,
      int currentAnswerIndex});
}

/// @nodoc
class _$CheckSeedPhraseCubitStateAnswerCopyWithImpl<$Res>
    implements $CheckSeedPhraseCubitStateAnswerCopyWith<$Res> {
  _$CheckSeedPhraseCubitStateAnswerCopyWithImpl(this._self, this._then);

  final CheckSeedPhraseCubitStateAnswer _self;
  final $Res Function(CheckSeedPhraseCubitStateAnswer) _then;

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableAnswers = null,
    Object? userAnswers = null,
    Object? currentAnswerIndex = null,
  }) {
    return _then(CheckSeedPhraseCubitStateAnswer(
      null == availableAnswers
          ? _self._availableAnswers
          : availableAnswers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == userAnswers
          ? _self._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<CheckSeedCorrectAnswer>,
      null == currentAnswerIndex
          ? _self.currentAnswerIndex
          : currentAnswerIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class CheckSeedPhraseCubitStateCorrect
    with DiagnosticableTreeMixin
    implements CheckSeedPhraseCubitState {
  const CheckSeedPhraseCubitStateCorrect(final List<String> availableAnswers,
      final List<CheckSeedCorrectAnswer> userAnswers)
      : _availableAnswers = availableAnswers,
        _userAnswers = userAnswers;

  final List<String> _availableAnswers;
  List<String> get availableAnswers {
    if (_availableAnswers is EqualUnmodifiableListView)
      return _availableAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAnswers);
  }

  final List<CheckSeedCorrectAnswer> _userAnswers;
  List<CheckSeedCorrectAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckSeedPhraseCubitStateCorrectCopyWith<CheckSeedPhraseCubitStateCorrect>
      get copyWith => _$CheckSeedPhraseCubitStateCorrectCopyWithImpl<
          CheckSeedPhraseCubitStateCorrect>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CheckSeedPhraseCubitState.correct'))
      ..add(DiagnosticsProperty('availableAnswers', availableAnswers))
      ..add(DiagnosticsProperty('userAnswers', userAnswers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckSeedPhraseCubitStateCorrect &&
            const DeepCollectionEquality()
                .equals(other._availableAnswers, _availableAnswers) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableAnswers),
      const DeepCollectionEquality().hash(_userAnswers));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckSeedPhraseCubitState.correct(availableAnswers: $availableAnswers, userAnswers: $userAnswers)';
  }
}

/// @nodoc
abstract mixin class $CheckSeedPhraseCubitStateCorrectCopyWith<$Res>
    implements $CheckSeedPhraseCubitStateCopyWith<$Res> {
  factory $CheckSeedPhraseCubitStateCorrectCopyWith(
          CheckSeedPhraseCubitStateCorrect value,
          $Res Function(CheckSeedPhraseCubitStateCorrect) _then) =
      _$CheckSeedPhraseCubitStateCorrectCopyWithImpl;
  @useResult
  $Res call(
      {List<String> availableAnswers,
      List<CheckSeedCorrectAnswer> userAnswers});
}

/// @nodoc
class _$CheckSeedPhraseCubitStateCorrectCopyWithImpl<$Res>
    implements $CheckSeedPhraseCubitStateCorrectCopyWith<$Res> {
  _$CheckSeedPhraseCubitStateCorrectCopyWithImpl(this._self, this._then);

  final CheckSeedPhraseCubitStateCorrect _self;
  final $Res Function(CheckSeedPhraseCubitStateCorrect) _then;

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableAnswers = null,
    Object? userAnswers = null,
  }) {
    return _then(CheckSeedPhraseCubitStateCorrect(
      null == availableAnswers
          ? _self._availableAnswers
          : availableAnswers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == userAnswers
          ? _self._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<CheckSeedCorrectAnswer>,
    ));
  }
}

/// @nodoc

class CheckSeedPhraseCubitStateError
    with DiagnosticableTreeMixin
    implements CheckSeedPhraseCubitState {
  const CheckSeedPhraseCubitStateError(final List<String> availableAnswers,
      final List<CheckSeedCorrectAnswer> userAnswers)
      : _availableAnswers = availableAnswers,
        _userAnswers = userAnswers;

  final List<String> _availableAnswers;
  List<String> get availableAnswers {
    if (_availableAnswers is EqualUnmodifiableListView)
      return _availableAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAnswers);
  }

  final List<CheckSeedCorrectAnswer> _userAnswers;
  List<CheckSeedCorrectAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CheckSeedPhraseCubitStateErrorCopyWith<CheckSeedPhraseCubitStateError>
      get copyWith => _$CheckSeedPhraseCubitStateErrorCopyWithImpl<
          CheckSeedPhraseCubitStateError>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'CheckSeedPhraseCubitState.error'))
      ..add(DiagnosticsProperty('availableAnswers', availableAnswers))
      ..add(DiagnosticsProperty('userAnswers', userAnswers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CheckSeedPhraseCubitStateError &&
            const DeepCollectionEquality()
                .equals(other._availableAnswers, _availableAnswers) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_availableAnswers),
      const DeepCollectionEquality().hash(_userAnswers));

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CheckSeedPhraseCubitState.error(availableAnswers: $availableAnswers, userAnswers: $userAnswers)';
  }
}

/// @nodoc
abstract mixin class $CheckSeedPhraseCubitStateErrorCopyWith<$Res>
    implements $CheckSeedPhraseCubitStateCopyWith<$Res> {
  factory $CheckSeedPhraseCubitStateErrorCopyWith(
          CheckSeedPhraseCubitStateError value,
          $Res Function(CheckSeedPhraseCubitStateError) _then) =
      _$CheckSeedPhraseCubitStateErrorCopyWithImpl;
  @useResult
  $Res call(
      {List<String> availableAnswers,
      List<CheckSeedCorrectAnswer> userAnswers});
}

/// @nodoc
class _$CheckSeedPhraseCubitStateErrorCopyWithImpl<$Res>
    implements $CheckSeedPhraseCubitStateErrorCopyWith<$Res> {
  _$CheckSeedPhraseCubitStateErrorCopyWithImpl(this._self, this._then);

  final CheckSeedPhraseCubitStateError _self;
  final $Res Function(CheckSeedPhraseCubitStateError) _then;

  /// Create a copy of CheckSeedPhraseCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? availableAnswers = null,
    Object? userAnswers = null,
  }) {
    return _then(CheckSeedPhraseCubitStateError(
      null == availableAnswers
          ? _self._availableAnswers
          : availableAnswers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == userAnswers
          ? _self._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<CheckSeedCorrectAnswer>,
    ));
  }
}

// dart format on
