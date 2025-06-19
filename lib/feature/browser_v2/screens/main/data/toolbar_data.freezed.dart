// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toolbar_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ToolbarData {
  bool get isCanGoBack => throw _privateConstructorUsedError;
  bool get isCanGoForward => throw _privateConstructorUsedError;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToolbarDataCopyWith<ToolbarData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolbarDataCopyWith<$Res> {
  factory $ToolbarDataCopyWith(
          ToolbarData value, $Res Function(ToolbarData) then) =
      _$ToolbarDataCopyWithImpl<$Res, ToolbarData>;
  @useResult
  $Res call({bool isCanGoBack, bool isCanGoForward});
}

/// @nodoc
class _$ToolbarDataCopyWithImpl<$Res, $Val extends ToolbarData>
    implements $ToolbarDataCopyWith<$Res> {
  _$ToolbarDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCanGoBack = null,
    Object? isCanGoForward = null,
  }) {
    return _then(_value.copyWith(
      isCanGoBack: null == isCanGoBack
          ? _value.isCanGoBack
          : isCanGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanGoForward: null == isCanGoForward
          ? _value.isCanGoForward
          : isCanGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ToolbarDataImplCopyWith<$Res>
    implements $ToolbarDataCopyWith<$Res> {
  factory _$$ToolbarDataImplCopyWith(
          _$ToolbarDataImpl value, $Res Function(_$ToolbarDataImpl) then) =
      __$$ToolbarDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCanGoBack, bool isCanGoForward});
}

/// @nodoc
class __$$ToolbarDataImplCopyWithImpl<$Res>
    extends _$ToolbarDataCopyWithImpl<$Res, _$ToolbarDataImpl>
    implements _$$ToolbarDataImplCopyWith<$Res> {
  __$$ToolbarDataImplCopyWithImpl(
      _$ToolbarDataImpl _value, $Res Function(_$ToolbarDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCanGoBack = null,
    Object? isCanGoForward = null,
  }) {
    return _then(_$ToolbarDataImpl(
      isCanGoBack: null == isCanGoBack
          ? _value.isCanGoBack
          : isCanGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanGoForward: null == isCanGoForward
          ? _value.isCanGoForward
          : isCanGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ToolbarDataImpl with DiagnosticableTreeMixin implements _ToolbarData {
  const _$ToolbarDataImpl(
      {this.isCanGoBack = false, this.isCanGoForward = false});

  @override
  @JsonKey()
  final bool isCanGoBack;
  @override
  @JsonKey()
  final bool isCanGoForward;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ToolbarData(isCanGoBack: $isCanGoBack, isCanGoForward: $isCanGoForward)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ToolbarData'))
      ..add(DiagnosticsProperty('isCanGoBack', isCanGoBack))
      ..add(DiagnosticsProperty('isCanGoForward', isCanGoForward));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolbarDataImpl &&
            (identical(other.isCanGoBack, isCanGoBack) ||
                other.isCanGoBack == isCanGoBack) &&
            (identical(other.isCanGoForward, isCanGoForward) ||
                other.isCanGoForward == isCanGoForward));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCanGoBack, isCanGoForward);

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolbarDataImplCopyWith<_$ToolbarDataImpl> get copyWith =>
      __$$ToolbarDataImplCopyWithImpl<_$ToolbarDataImpl>(this, _$identity);
}

abstract class _ToolbarData implements ToolbarData {
  const factory _ToolbarData(
      {final bool isCanGoBack, final bool isCanGoForward}) = _$ToolbarDataImpl;

  @override
  bool get isCanGoBack;
  @override
  bool get isCanGoForward;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToolbarDataImplCopyWith<_$ToolbarDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
