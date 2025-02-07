import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'setting_page.dart';
import '../../store.dart';

class SettingColumnPage extends StatelessWidget {
  const SettingColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final columnNum =
        context.select<GlobalStore, int>((store) => store.columnNum);
    final sectionItem = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w500);

    return SettingPage(
        title: AppLocalizations.of(context)!.column,
        child: SafeArea(
            child: CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            for (var i = 0; i <= 4; i++)
              CupertinoListTile(
                title: Text(
                    i == 0 ? AppLocalizations.of(context)!.auto : i.toString(),
                    style: sectionItem),
                onTap: () => context.read<GlobalStore>().setColumnNum(i),
                trailing: columnNum == i
                    ? const Icon(CupertinoIcons.check_mark)
                    : null,
              )
          ],
        )));
  }
}
