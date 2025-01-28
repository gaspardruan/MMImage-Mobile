import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/image_suit.dart';
import '../widgets/image_grid.dart';

class AlbumDetailPage extends StatelessWidget {
  const AlbumDetailPage({super.key, required this.images, required this.name});

  final List<ImageSuit> images;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48,
        leading: IconButton(
          iconSize: 20,
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: const TextStyle(fontSize: 16),
        title: Row(
          children: [
            Text(name),
            SizedBox(
              width: 2,
            ),
            Text(images.length.toString(),
                style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(150))),
          ],
        ),
        titleSpacing: 0,
      ),
      body: ImageGrid(images: images),
    );
  }
}
