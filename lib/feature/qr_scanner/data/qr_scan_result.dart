import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'qr_scan_result.freezed.dart';

@freezed
sealed class QrScanResult with _$QrScanResult {
  const factory QrScanResult.address(Address value) = QrScanResultAddress;
  const factory QrScanResult.uri(Uri value) = QrScanResultUri;
}
