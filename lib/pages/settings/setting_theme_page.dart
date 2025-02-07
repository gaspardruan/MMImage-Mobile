import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: AppLocalizations.of(context)!.theme,
        child: SafeArea(
            child: CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.system,
                  style: sectionItem),
              onTap: () {
                setThemeMode(ThemeMode.system);
              },
              trailing: themeMode == ThemeMode.system
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title:
                  Text(AppLocalizations.of(context)!.light, style: sectionItem),
              onTap: () {
                setThemeMode(ThemeMode.light);
              },
              trailing: themeMode == ThemeMode.light
                  ? const Icon(CupertinoIcons.check_mark)
                  : null,
            ),
            CupertinoListTile(
              title:
                  Text(AppLocalizations.of(context)!.dark, style: sectionItem),
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
