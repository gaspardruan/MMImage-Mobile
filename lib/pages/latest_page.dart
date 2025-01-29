import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/image_store.dart';
import '../widgets/image_grid.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    log("LatestPage build");
    final imageStore = context.watch<ImageStore>();
    final images = imageStore.latest;
    return ImageGrid(key: Key("Latest-${images.length}"), images: images);
  }
}
