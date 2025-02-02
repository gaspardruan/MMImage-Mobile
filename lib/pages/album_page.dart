import 'dart:developer';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mmimage_mobile/models/name_model.dart';
import 'package:provider/provider.dart';

import '../models/beauty_suit.dart';
import '../models/image_suit.dart';
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

    final nameStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
    final numStyle = TextStyle(
        fontSize: 9,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(180));
    final tagStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant);
    final borderColor = Theme.of(context).focusColor;

    log("AlbumPage build");

    return SafeArea(
      minimum: EdgeInsets.only(left: 16),
      child: AzListView(
        key: Key('Album-${images.length}'),
        data: names,
        itemCount: names.length,
        itemBuilder: (context, index) {
          final NameModel name = names[index];
          return ListTile(
            title: Row(
              children: [
                Text(name.name, style: nameStyle),
                const SizedBox(
                  width: 2,
                ),
                Text(albums[name.name]!.num.toString(), style: numStyle),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity.compact,
            shape: Border(bottom: BorderSide(width: 0.5, color: borderColor)),
            onTap: () {
              Navigator.of(context).pushNamed(CustomRoute.albumDetailPage,
                  arguments: (
                    name: name.name,
                    images: albums[name.name]!.suits
                  ));
            },
          );
        },
        susItemBuilder: (context, index) {
          final String tag = names[index].getSuspensionTag();
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: borderColor),
              ),
            ),
            height: 45,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(tag, style: tagStyle),
            ),
          );
        },
        susPosition: Offset.infinite,
        indexBarWidth: 16,
        indexBarData: tags,
        indexBarOptions: IndexBarOptions(
          textStyle: TextStyle(fontSize: 10, color: Colors.deepPurpleAccent),
          color: Theme.of(context).scaffoldBackgroundColor,
          downColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
