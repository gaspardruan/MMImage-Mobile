import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/image_suit.dart';
import '../route.dart';
import '../store.dart';
import '../utils.dart';

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

    final imageNumStr = '${latest.length}';
    final lastUpdateStr = getTimeStr(lastUpdate);

    final sectionHeader = Theme.of(context).textTheme.labelMedium;
    final sectionItem = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w500);
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final fontLarge = const TextStyle(fontSize: 16);

    return SafeArea(
        child: Column(
      children: [
        CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          header:
              Text(AppLocalizations.of(context)!.setting, style: sectionHeader),
          backgroundColor: backgroundColor,
          children: [
            CupertinoListTile(
              title:
                  Text(AppLocalizations.of(context)!.theme, style: sectionItem),
              onTap: () =>
                  Navigator.pushNamed(context, CustomRoute.settingThemePage),
              additionalInfo: ThemeString(),
              trailing: const CupertinoListTileChevron(),
            ),
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.column,
                  style: sectionItem),
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
          header:
              Text(AppLocalizations.of(context)!.data, style: sectionHeader),
          backgroundColor: backgroundColor,
          children: [
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.quantity,
                  style: sectionItem),
              additionalInfo: Text(imageNumStr, style: fontLarge),
            ),
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.lastUpdate,
                  style: sectionItem),
              additionalInfo: Text(lastUpdateStr, style: fontLarge),
            ),
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.version,
                  style: sectionItem),
              additionalInfo: Text(version, style: fontLarge),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          header:
              Text(AppLocalizations.of(context)!.about, style: sectionHeader),
          backgroundColor: backgroundColor,
          children: [
            CupertinoListTile(
              title: Text(AppLocalizations.of(context)!.author,
                  style: sectionItem),
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

  String getColumnNumStr(BuildContext context, int columnNum) {
    return columnNum == 0
        ? AppLocalizations.of(context)!.auto
        : columnNum.toString();
  }

  @override
  Widget build(BuildContext context) {
    final columnNum =
        context.select<GlobalStore, int>((store) => store.columnNum);
    final columnNumStr = getColumnNumStr(context, columnNum);
    return Text(columnNumStr, style: const TextStyle(fontSize: 16));
  }
}

class ThemeString extends StatelessWidget {
  const ThemeString({super.key});

  String getThemeModeStr(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return AppLocalizations.of(context)!.system;
      case ThemeMode.light:
        return AppLocalizations.of(context)!.light;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<GlobalStore, ThemeMode>((store) => store.themeMode);
    final themeStr = getThemeModeStr(context, themeMode);
    return Text(themeStr, style: const TextStyle(fontSize: 16));
  }
}
