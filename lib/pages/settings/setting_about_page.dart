import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'setting_page.dart';
import '../../utils.dart';

class SettingAboutPage extends StatelessWidget {
  const SettingAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionItem = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w500);
    final plainText = TextStyle(
        letterSpacing: 1,
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(180));

    return SettingPage(
      title: AppLocalizations.of(context)!.author,
      child: CupertinoListSection.insetGrouped(
        hasLeading: false,
        dividerMargin: 6,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Text(AppLocalizations.of(context)!.declaration, style: plainText),
        ),
        children: [
          CupertinoListTile(
            title:
                Text(AppLocalizations.of(context)!.github, style: sectionItem),
            trailing: const CupertinoListTileChevron(),
            onTap: () => goGithubHome(),
          ),
          CupertinoListTile(
            title: Text(AppLocalizations.of(context)!.bilibili,
                style: sectionItem),
            trailing: const CupertinoListTileChevron(),
            onTap: () => goBilibiliHome(),
          ),
        ],
      ),
    );
  }
}
