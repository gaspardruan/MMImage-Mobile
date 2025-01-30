import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmimage_mobile/utils.dart';
import 'package:provider/provider.dart';

import '../stores/global_store.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    final globalStore = context.watch<GlobalStore>();
    final themeStr = getThemeModeStr(globalStore.themeMode);
    final columnNumStr = getColumnNumStr(globalStore.columnNum);
    final imageNumStr = '${globalStore.latest.length} 套';
    final lastUpdateStr = getTimeStr(globalStore.lastUpdate);

    return SafeArea(
        child: Column(
      children: [
        CupertinoFormSection.insetGrouped(
          header: const Text('外观', style: TextStyle(fontSize: 12)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoFormRow(
              prefix: const Text("主题", style: TextStyle(fontSize: 14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(themeStr,
                      style: TextStyle(
                        color: CupertinoColors.systemGrey2.resolveFrom(context),
                      )),
                  const CupertinoListTileChevron(),
                ],
              ),
            ),
            CupertinoFormRow(
                prefix: const Text('列数', style: TextStyle(fontSize: 14)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(columnNumStr,
                        style: TextStyle(
                          color:
                              CupertinoColors.systemGrey2.resolveFrom(context),
                        )),
                    const CupertinoListTileChevron(),
                  ],
                )),
          ],
        ),
        CupertinoFormSection.insetGrouped(
          header: const Text('数据', style: TextStyle(fontSize: 12)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoFormRow(
              prefix: const Text("套图总数", style: TextStyle(fontSize: 14)),
              child: Text(imageNumStr,
                  style: TextStyle(
                      color: CupertinoColors.systemGrey2.resolveFrom(context))),
            ),
            CupertinoFormRow(
              prefix: const Text("更新时间", style: TextStyle(fontSize: 14)),
              child: Text(lastUpdateStr,
                  style: TextStyle(
                      color: CupertinoColors.systemGrey2.resolveFrom(context))),
            ),
          ],
        ),
        CupertinoFormSection.insetGrouped(
          header: const Text('我', style: TextStyle(fontSize: 12)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoFormRow(
              prefix: const Text("关于作者", style: TextStyle(fontSize: 14)),
              child: const CupertinoListTileChevron(),
            )
          ],
        )
      ],
    ));
  }
}
