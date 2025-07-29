// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toolbar_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToolbarData implements DiagnosticableTreeMixin {
  bool get isCanGoBack;
  bool get isCanGoForward;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ToolbarDataCopyWith<ToolbarData> get copyWith =>
      _$ToolbarDataCopyWithImpl<ToolbarData>(this as ToolbarData, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ToolbarData'))
      ..add(DiagnosticsProperty('isCanGoBack', isCanGoBack))
      ..add(DiagnosticsProperty('isCanGoForward', isCanGoForward));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToolbarData &&
            (identical(other.isCanGoBack, isCanGoBack) ||
                other.isCanGoBack == isCanGoBack) &&
            (identical(other.isCanGoForward, isCanGoForward) ||
                other.isCanGoForward == isCanGoForward));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCanGoBack, isCanGoForward);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ToolbarData(isCanGoBack: $isCanGoBack, isCanGoForward: $isCanGoForward)';
  }
}

/// @nodoc
abstract mixin class $ToolbarDataCopyWith<$Res> {
  factory $ToolbarDataCopyWith(
          ToolbarData value, $Res Function(ToolbarData) _then) =
      _$ToolbarDataCopyWithImpl;
  @useResult
  $Res call({bool isCanGoBack, bool isCanGoForward});
}

/// @nodoc
class _$ToolbarDataCopyWithImpl<$Res> implements $ToolbarDataCopyWith<$Res> {
  _$ToolbarDataCopyWithImpl(this._self, this._then);

  final ToolbarData _self;
  final $Res Function(ToolbarData) _then;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCanGoBack = null,
    Object? isCanGoForward = null,
  }) {
    return _then(_self.copyWith(
      isCanGoBack: null == isCanGoBack
          ? _self.isCanGoBack
          : isCanGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanGoForward: null == isCanGoForward
          ? _self.isCanGoForward
          : isCanGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _ToolbarData with DiagnosticableTreeMixin implements ToolbarData {
  const _ToolbarData({this.isCanGoBack = false, this.isCanGoForward = false});

  @override
  @JsonKey()
  final bool isCanGoBack;
  @override
  @JsonKey()
  final bool isCanGoForward;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ToolbarDataCopyWith<_ToolbarData> get copyWith =>
      __$ToolbarDataCopyWithImpl<_ToolbarData>(this, _$identity);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'ToolbarData'))
      ..add(DiagnosticsProperty('isCanGoBack', isCanGoBack))
      ..add(DiagnosticsProperty('isCanGoForward', isCanGoForward));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ToolbarData &&
            (identical(other.isCanGoBack, isCanGoBack) ||
                other.isCanGoBack == isCanGoBack) &&
            (identical(other.isCanGoForward, isCanGoForward) ||
                other.isCanGoForward == isCanGoForward));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCanGoBack, isCanGoForward);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ToolbarData(isCanGoBack: $isCanGoBack, isCanGoForward: $isCanGoForward)';
  }
}

/// @nodoc
abstract mixin class _$ToolbarDataCopyWith<$Res>
    implements $ToolbarDataCopyWith<$Res> {
  factory _$ToolbarDataCopyWith(
          _ToolbarData value, $Res Function(_ToolbarData) _then) =
      __$ToolbarDataCopyWithImpl;
  @override
  @useResult
  $Res call({bool isCanGoBack, bool isCanGoForward});
}

/// @nodoc
class __$ToolbarDataCopyWithImpl<$Res> implements _$ToolbarDataCopyWith<$Res> {
  __$ToolbarDataCopyWithImpl(this._self, this._then);

  final _ToolbarData _self;
  final $Res Function(_ToolbarData) _then;

  /// Create a copy of ToolbarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCanGoBack = null,
    Object? isCanGoForward = null,
  }) {
    return _then(_ToolbarData(
      isCanGoBack: null == isCanGoBack
          ? _self.isCanGoBack
          : isCanGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanGoForward: null == isCanGoForward
          ? _self.isCanGoForward
          : isCanGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
