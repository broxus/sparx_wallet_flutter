import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

@Freezed(unionKey: 'name')
sealed class Feature with _$Feature {
  @FreezedUnionValue('SendTransaction')
  const factory Feature.sendTransaction({required int maxMessages}) =
      _SendTransaction;

  @FreezedUnionValue('SignData')
  const factory Feature.signData({required List<String> types}) = _SignData;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}
