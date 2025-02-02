import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store.dart';
import '../widgets/image_grid.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalStore = context.watch<GlobalStore>();
    final columnNum = globalStore.columnNum;
    final themeMode = globalStore.themeMode;
    final images = globalStore.latest;
    return SafeArea(
        child: ImageGrid(
            key: Key(
                "Latest-${images.length}-$columnNum-${themeMode.toString()}"),
            images: images));
  }
}
