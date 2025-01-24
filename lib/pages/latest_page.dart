import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/image_suit.dart';
import '../utils.dart';

class LatestPage extends StatefulWidget {
  LatestPage({super.key, required this.images})
      : _maxPage = (images.length / pageSize).ceil();
  final int _maxPage;
  final List<ImageSuit> images;

  @override
  State<LatestPage> createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  int _page = 0;
  final List<String> visibleImages = [];
  final HashSet<int> _cachedIndexes = HashSet<int>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_page == 0) {
      visibleImages.addAll(_newPage);
    }
    _preloadImage(_page * pageSize, coverCacheStep);
  }

  void _preloadImage(int start, [int len = 1]) {
    if (start < 0 || start >= visibleImages.length) {
      return;
    }
    final int end = min(visibleImages.length, start + len);
    for (int i = start; i < end; i++) {
      if (!_cachedIndexes.contains(i)) {
        final String url = visibleImages[i];
        precacheImage(CachedNetworkImageProvider(url), context);
        _cachedIndexes.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SafeArea(
            child: Scrollbar(
          radius: const Radius.circular(2),
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: visibleImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (constraints.maxWidth - 16) ~/ 160,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) => _suitCover(context, index),
          ),
        )),
      );
    });
  }

  GestureDetector _suitCover(BuildContext context, int index) {
    _preloadImage(index + coverCacheStep);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view',
            arguments: getImageURLs(widget.images[index]));
      },
      child: CachedNetworkImage(
        imageUrl: visibleImages[index],
        fadeInDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  // when hit the bottom of the gridview, load more images
  ScrollController get _scrollController {
    var controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          _page + 1 < widget._maxPage) {
        setState(() {
          _page++;
          visibleImages.addAll(_newPage);
        });
      }
    });
    return controller;
  }

  Iterable<String> get _newPage {
    var start = _page * pageSize;
    var end = min((_page + 1) * pageSize, widget.images.length);
    return widget.images
        .getRange(start, end)
        .map((e) => getCoverURL(e.id, e.prefix));
  }
}
