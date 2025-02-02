import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmimage_mobile/utils.dart';
import 'package:provider/provider.dart';

import '../models/image_suit.dart';
import '../route.dart';
import '../store.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final version =
        context.select<GlobalStore, String>((store) => store.version);

    final latest =
        context.select<GlobalStore, List<ImageSuit>>((store) => store.latest);
    final lastUpdate =
        context.select<GlobalStore, DateTime>((store) => store.lastUpdate);

    final imageNumStr = '${latest.length} 套';
    final lastUpdateStr = getTimeStr(lastUpdate);

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
          header: Text('设置', style: smallText),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text("主题", style: normalText),
              onTap: () =>
                  Navigator.pushNamed(context, CustomRoute.settingThemePage),
              additionalInfo: ThemeString(),
              trailing: const CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              title: Text("列数", style: normalText),
              onTap: () =>
                  Navigator.pushNamed(context, CustomRoute.settingColumnPage),
              additionalInfo: ColumnString(),
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
              additionalInfo: Text(imageNumStr, style: TextStyle(fontSize: 14)),
            ),
            CupertinoListTile(
              title: Text("最后更新", style: normalText),
              additionalInfo:
                  Text(lastUpdateStr, style: TextStyle(fontSize: 14)),
            ),
            CupertinoListTile(
              title: Text("版本", style: normalText),
              additionalInfo: Text(version, style: TextStyle(fontSize: 14)),
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
                Navigator.pushNamed(context, CustomRoute.settingAboutPage),
              },
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ],
    ));
  }
}

class ColumnString extends StatelessWidget {
  const ColumnString({super.key});

  @override
  Widget build(BuildContext context) {
    final columnNum =
        context.select<GlobalStore, int>((store) => store.columnNum);
    final columnNumStr = getColumnNumStr(columnNum);
    return Text(columnNumStr, style: TextStyle(fontSize: 14));
  }
}

class ThemeString extends StatelessWidget {
  const ThemeString({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<GlobalStore, ThemeMode>((store) => store.themeMode);
    final themeStr = getThemeModeStr(themeMode);
    return Text(themeStr, style: TextStyle(fontSize: 14));
  }
}
