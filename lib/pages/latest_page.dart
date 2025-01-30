import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/global_store.dart';
import '../widgets/image_grid.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageStore = context.watch<GlobalStore>();
    final images = imageStore.latest;
    return SafeArea(
        child: ImageGrid(key: Key("Latest-${images.length}"), images: images));
  }
}
