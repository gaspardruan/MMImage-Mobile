import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/global_store.dart';
import 'setting_page.dart';

class SettingThemePage extends StatelessWidget {
  const SettingThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalStore = context.watch<GlobalStore>();

    final normalText =
        TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface);

    return SettingPage(
        title: '主题',
        child: SafeArea(
            child: CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text("跟随系统", style: normalText),
              onTap: () {
                globalStore.setThemeMode(ThemeMode.system);
              },
              trailing: globalStore.themeMode == ThemeMode.system
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title: Text("浅色", style: normalText),
              onTap: () {
                globalStore.setThemeMode(ThemeMode.light);
              },
              trailing: globalStore.themeMode == ThemeMode.light
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title: Text("深色", style: normalText),
              onTap: () {
                globalStore.setThemeMode(ThemeMode.dark);
              },
              trailing: globalStore.themeMode == ThemeMode.dark
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
          ],
        )));
  }
}
