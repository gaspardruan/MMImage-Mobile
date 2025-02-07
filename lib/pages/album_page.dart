import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/beauty_suit.dart';
import '../models/image_suit.dart';
import '../models/name_model.dart';
import '../route.dart';
import '../store.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final images =
        context.select<GlobalStore, List<ImageSuit>>((store) => store.latest);
    final names =
        context.select<GlobalStore, List<NameModel>>((store) => store.names);
    final albums = context.select<GlobalStore, Map<String, ImageCollection>>(
        (store) => store.albums);
    final tags =
        context.select<GlobalStore, List<String>>((store) => store.tags);

    final numStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
        );
    final borderColor = Theme.of(context).focusColor;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SafeArea(
      minimum: EdgeInsets.only(left: 16),
      child: AzListView(
        key: Key('Album-${images.length}'),
        data: names,
        itemCount: names.length,
        itemBuilder: (context, index) {
          final NameModel nameItem = names[index];
          return Column(
            children: [
              Offstage(
                  offstage: nameItem.isShowSuspension != true,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: borderColor),
                      ),
                    ),
                    height: 45,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(nameItem.getSuspensionTag(),
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  )),
              ListTile(
                title: Row(
                  children: [
                    Text(nameItem.name,
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(albums[nameItem.name]!.num.toString(),
                        style: numStyle),
                  ],
                ),
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
                shape:
                    Border(bottom: BorderSide(width: 0.5, color: borderColor)),
                onTap: () {
                  Navigator.of(context).pushNamed(CustomRoute.albumDetailPage,
                      arguments: (
                        name: nameItem.name,
                        images: albums[nameItem.name]!.suits
                      ));
                },
              ),
            ],
          );
        },
        indexBarWidth: 16,
        indexBarData: tags,
        indexBarOptions: IndexBarOptions(
          textStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.deepPurpleAccent),
          color: backgroundColor,
          downColor: backgroundColor,
        ),
      ),
    );
  }
}
