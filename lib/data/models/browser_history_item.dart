import 'package:app/data/models/browser_item.dart';
import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

part 'browser_history_item.freezed.dart';

part 'browser_history_item.g.dart';

@freezed
class BrowserHistoryItem with _$BrowserHistoryItem  implements BrowserItem {
  const factory BrowserHistoryItem({
    /// The id of the tab.
    required String id,
    required String title,
    @uriJsonConverter required Uri uri,
    required DateTime visitTime,
  }) = _BrowserHistoryItemDto;

  factory BrowserHistoryItem.create({
    @uriJsonConverter required Uri uri,
  }) =>
      BrowserHistoryItem(
        id: const Uuid().v4(),
        title: uri.host,
        uri: uri,
        visitTime: NtpTime.now(),
      );

  const BrowserHistoryItem._();

  factory BrowserHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$BrowserHistoryItemFromJson(json);
}
