import 'package:app/feature/browser_v2/data/broser_entity.dart';
import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:uuid/uuid.dart';

part 'browser_tab.freezed.dart';

part 'browser_tab.g.dart';

@unfreezed
class BrowserTab with _$BrowserTab implements BrowserEntity {
  factory BrowserTab({
    /// The id of the tab.
    required final String id,

    /// Initial url of the tab.
    @uriJsonConverter required Uri url,

    /// The title of the tab.
    required String? title,

    /// The sorting position of the tab.
    required double sortingOrder,
  }) = _BrowserTab;

  factory BrowserTab.create({
    required Uri url,
  }) =>
      BrowserTab(
        id: const Uuid().v4(),
        url: url,
        title: null,
        sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
      );

  BrowserTab._();

  factory BrowserTab.fromJson(Map<String, dynamic> json) =>
      _$BrowserTabFromJson(json);
}

extension BrowserTabExtension on BrowserTab {
  bool get isNotEmptyHost => url.host.isNotEmpty;
}
