import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'setting_page.dart';
import '../../store.dart';

class SettingThemePage extends StatelessWidget {
  const SettingThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<GlobalStore, ThemeMode>((store) => store.themeMode);
    final setThemeMode = context.read<GlobalStore>().setThemeMode;
    final sectionItem = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w500);

    return SettingPage(
        title: '主题',
        child: SafeArea(
            child: CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text('跟随系统', style: sectionItem),
              onTap: () {
                setThemeMode(ThemeMode.system);
              },
              trailing: themeMode == ThemeMode.system
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title: Text('浅色', style: sectionItem),
              onTap: () {
                setThemeMode(ThemeMode.light);
              },
              trailing: themeMode == ThemeMode.light
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title: Text('深色', style: sectionItem),
              onTap: () {
                setThemeMode(ThemeMode.dark);
              },
              trailing: themeMode == ThemeMode.dark
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
          ],
        )));
  }
}
