import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/image_grid.dart';
import '../models/image_suit.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({super.key, required this.images});

  final List<ImageSuit> images;

  @override
  State<LatestPage> createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  @override
  Widget build(BuildContext context) {
    log("LatestPage build");
    return ImageGrid(images: widget.images);
  }
}
