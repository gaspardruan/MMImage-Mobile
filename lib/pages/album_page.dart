import 'dart:developer';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:mmimage_mobile/models/name_model.dart';

import '../models/beauty_suit.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage(
      {super.key,
      required this.names,
      required this.albums,
      required this.tags});
  final List<NameModel> names;
  final Map<String, ImageCollection> albums;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    log('AlbumPage.build');
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
                Text(name.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface)),
                SizedBox(
                  width: 2,
                ),
                Text(albums[name.name]!.num.toString(),
                    style: TextStyle(
                        fontSize: 9,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(150))),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity.compact,
            shape: Border(
                bottom: BorderSide(
                    width: 0.5, color: Theme.of(context).focusColor)),
            onTap: () {
              // 处理点击事件
            },
          );
        },
        susItemBuilder: (context, index) {
          final String tag = names[index].getSuspensionTag();
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom:
                    BorderSide(width: 0.5, color: Theme.of(context).focusColor),
              ),
            ),
            height: 45,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(tag,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
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

        // susItemHeight: 80,
      ),
    );
  }
}
