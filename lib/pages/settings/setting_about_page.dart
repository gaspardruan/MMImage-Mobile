import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'setting_page.dart';
import '../../utils.dart';

class SettingAboutPage extends StatelessWidget {
  const SettingAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionItem = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.w600);
    final plainText = TextStyle(
        letterSpacing: 1,
        fontSize: 12,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(180));

    return SettingPage(
      title: '关于作者',
      child: CupertinoListSection.insetGrouped(
        hasLeading: false,
        dividerMargin: 6,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              '图片数据来自互联网，开发应用以学习使用，应用代码均开源在Github上，欢迎提出issue和建议。\n\n'
              '如果觉得应用不错，Github上给个Star，也可以在B站上关注我，后续有时间会开发其他应用。',
              style: plainText),
        ),
        children: [
          CupertinoListTile(
            title: Text('Github主页', style: sectionItem),
            trailing: const CupertinoListTileChevron(),
            onTap: () => goGithubHome(),
          ),
          CupertinoListTile(
            title: Text('Bilibili主页', style: sectionItem),
            trailing: const CupertinoListTileChevron(),
            onTap: () => goBilibiliHome(),
          ),
        ],
      ),
    );
  }
}
