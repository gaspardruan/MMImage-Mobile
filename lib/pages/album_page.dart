import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mmimage_mobile/models/name_model.dart';
import 'package:provider/provider.dart';

import '../route.dart';
import '../stores/global_store.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageStore = context.watch<GlobalStore>();
    final names = imageStore.names;
    final albums = imageStore.albums;
    final tags = imageStore.tags;

    final nameStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
    final numStyle = TextStyle(
        fontSize: 9,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(150));
    final tagStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant);
    final borderColor = Theme.of(context).focusColor;

    return SafeArea(
      minimum: EdgeInsets.only(left: 16),
      child: AzListView(
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
        susItemHeight: 45,
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
