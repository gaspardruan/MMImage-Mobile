import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmimage_mobile/store.dart';
import 'package:provider/provider.dart';

import '../widgets/image_grid.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalStore = context.watch<GlobalStore>();
    final columnNum = globalStore.columnNum;
    final themeMode = globalStore.themeMode;
    final images = globalStore.collections.values.toList();
    return SafeArea(
      child: images.isEmpty
          ? const EmptyCollection()
          : ImageGrid(
              key: Key(
                  'Collection-${images.length}-$columnNum-${themeMode.toString()}'),
              images: images),
    );
  }
}

class EmptyCollection extends StatelessWidget {
  const EmptyCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.heart,
            size: 50, color: Theme.of(context).hintColor),
        SizedBox(height: 20),
        Text('收藏喜欢的套图以快速浏览', style: Theme.of(context).textTheme.bodyLarge),
      ],
    ));
  }
}
