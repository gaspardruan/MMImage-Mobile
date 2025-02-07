import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../store.dart';
import '../models/image_suit.dart';
import '../widgets/image_grid.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final columnNum =
        context.select<GlobalStore, int>((store) => store.columnNum);
    final images = context
        .select<GlobalStore, Map<String, ImageSuit>>(
            (store) => store.collections)
        .values
        .toList();

    // Without the key, the page will not be updated when the images change.
    return SafeArea(
      child: images.isEmpty
          ? const EmptyCollection()
          : ImageGrid(
              key: Key('Collection-${images.length}'),
              images: images,
              columnNum: columnNum,
            ),
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
        Text(AppLocalizations.of(context)!.empty_message,
            style: Theme.of(context).textTheme.bodyLarge),
      ],
    ));
  }
}
