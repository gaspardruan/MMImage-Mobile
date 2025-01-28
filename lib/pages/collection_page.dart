import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/image_suit.dart';
import '../widgets/image_grid.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key, required this.images});

  final List<ImageSuit> images;

  @override
  Widget build(BuildContext context) {
    log("CollectionPage build: ${images.length}");
    return SafeArea(
      child:
          images.isEmpty ? const EmptyCollection() : ImageGrid(images: images),
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
