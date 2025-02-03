import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/image_suit.dart';
import '../store.dart';
import '../widgets/image_grid.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final columnNum =
        context.select<GlobalStore, int>((store) => store.columnNum);
    final images =
        context.select<GlobalStore, List<ImageSuit>>((store) => store.latest);

    // Without the key, the page will not be updated when the images change.
    return SafeArea(
        child: ImageGrid(
      key: Key('Latest-${images.length}'),
      images: images,
      columnNum: columnNum,
    ));
  }
}
