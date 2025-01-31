import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmimage_mobile/utils.dart';
import 'package:provider/provider.dart';

import '../stores/global_store.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalStore = context.watch<GlobalStore>();
    final themeStr = getThemeModeStr(globalStore.themeMode);
    final columnNumStr = getColumnNumStr(globalStore.columnNum);
    final imageNumStr = '${globalStore.latest.length} 套';
    final lastUpdateStr = getTimeStr(globalStore.lastUpdate);

    final smallText =
        TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface);
    final normalText =
        TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface);

    return SafeArea(
        child: Column(
      children: [
        CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          header: Text('外观', style: smallText),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text("主题", style: normalText),
              onTap: () => Navigator.pushNamed(context, '/setting_theme'),
              additionalInfo: Text(themeStr, style: TextStyle(fontSize: 14)),
              trailing: const CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              title: Text("列数", style: normalText),
              onTap: () => Navigator.pushNamed(context, '/setting_column'),
              additionalInfo:
                  Text(columnNumStr, style: TextStyle(fontSize: 14)),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          header: Text('数据', style: smallText),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text("图片数量", style: normalText),
              onTap: () => {},
              additionalInfo: Text(imageNumStr, style: TextStyle(fontSize: 14)),
            ),
            CupertinoListTile(
              title: Text("最后更新", style: normalText),
              onTap: () => {},
              additionalInfo:
                  Text(lastUpdateStr, style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          header: Text('作者', style: smallText),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text("关于作者", style: normalText),
              onTap: () => {
                Navigator.pushNamed(context, '/setting_about'),
              },
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ],
    ));
  }
}
