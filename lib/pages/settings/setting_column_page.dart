import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        .copyWith(fontWeight: FontWeight.w600);

    return SettingPage(
        title: '列数',
        child: SafeArea(
            child: CupertinoListSection.insetGrouped(
          hasLeading: false,
          dividerMargin: 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          children: [
            for (var i = 0; i <= 4; i++)
              CupertinoListTile(
                title: Text(i == 0 ? '自动' : i.toString(), style: sectionItem),
                onTap: () => context.read<GlobalStore>().setColumnNum(i),
                trailing: columnNum == i
                    ? const Icon(CupertinoIcons.check_mark)
                    : null,
              )
          ],
        )));
  }
}
