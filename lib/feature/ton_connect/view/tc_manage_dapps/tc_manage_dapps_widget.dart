import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// LocaleKeys.connectedDappsSheetTitle.tr()

class TCManageDappsWidget
    extends InjectedElementaryWidget<TCManageDappsWidgetModel> {
  const TCManageDappsWidget({required this.scrollController, super.key})
    : super();

  final ScrollController scrollController;

  @override
  Widget build(TCManageDappsWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.connectionsState,
      builder: (_, connections) {
        if (connections == null || connections.isEmpty) {
          return const _EmptyPlaceholder();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.connectedDappsSheetTitle.tr(),
              style: wm.theme.textStyles.headingMedium,
            ),
            const SizedBox(height: DimensSizeV2.d24),
            Flexible(
              child: SingleChildScrollView(
                controller: scrollController,
                child: ShapedContainerColumn(
                  color: wm.theme.colors.background2,
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  spacing: DimensSizeV2.d0,
                  separator: const CommonDivider(
                    margin: EdgeInsets.symmetric(vertical: DimensSizeV2.d16),
                  ),
                  children: [
                    for (final connection in connections)
                      _Item(
                        key: ValueKey(connection),
                        connection: connection,
                        onDisconnect: wm.onDisconnect,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d24),
            DestructiveButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.disconnectAll.tr(),
              onPressed: wm.onDisconnectAll,
            ),
          ],
        );
      },
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: DimensSizeV2.d24,
            children: [
              Container(
                width: DimensSizeV2.d56,
                height: DimensSizeV2.d56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colors.background2,
                ),
                alignment: Alignment.center,
                child: const Icon(LucideIcons.unplug, size: DimensSizeV2.d24),
              ),
              Text(
                LocaleKeys.emptyConnectedDapps.tr(),
                style: theme.textStyles.headingLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.backWord.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.connection,
    required this.onDisconnect,
    super.key,
  });

  final TonAppConnection connection;
  final ValueChanged<TonAppConnection> onDisconnect;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: DimensSizeV2.d10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
          child: CachedNetworkImage(
            height: DimensSizeV2.d32,
            width: DimensSizeV2.d32,
            imageUrl: connection.manifest.iconUrl,
            placeholder: (_, __) => const CommonCircularProgressIndicator(),
            errorWidget: (_, __, ___) =>
                CommonIconWidget.svg(svg: Assets.images.web.path),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DimensSizeV2.d4,
            children: [
              Text(
                connection.manifest.name,
                style: context.themeStyleV2.textStyles.button,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                connection.manifest.url.replaceAll(RegExp('https?://'), ''),
                style: context.themeStyleV2.textStyles.labelXSmall.copyWith(
                  color: ColorsRes.grey898989,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          buttonSize: ButtonSize.mini,
          title: LocaleKeys.disconnect.tr(),
          onPressed: () => onDisconnect(connection),
        ),
      ],
    );
  }
}
