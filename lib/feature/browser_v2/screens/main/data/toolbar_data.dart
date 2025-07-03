import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toolbar_data.freezed.dart';

@freezed
abstract class ToolbarData with _$ToolbarData {
  const factory ToolbarData({
    @Default(false) bool isCanGoBack,
    @Default(false) bool isCanGoForward,
  }) = _ToolbarData;
}
