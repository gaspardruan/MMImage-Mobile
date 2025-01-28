import 'package:flutter/material.dart';

import '../widgets/image_grid.dart';
import '../models/image_suit.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key, required this.images});

  final List<ImageSuit> images;

  @override
  Widget build(BuildContext context) {
    return ImageGrid(images: images);
  }
}
