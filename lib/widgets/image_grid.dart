import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/image_suit.dart';
import '../route.dart';
import '../utils.dart';

class ImageGrid extends StatefulWidget {
  ImageGrid({super.key, required this.images, this.columnNum = 0})
      : _maxPage = (images.length / pageSize).ceil();
  final int _maxPage;
  final List<ImageSuit> images;
  final int columnNum;

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  int _page = 0;
  final List<String> visibleImages = [];
  final HashSet<int> _cachedIndexes = HashSet<int>();

  final _scrollController = ScrollController();
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_page == 0) {
      visibleImages.addAll(_newPage);
    }
    _preloadImage(_page * pageSize, coverCacheStep);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          _page + 1 < widget._maxPage) {
        setState(() {
          _page++;
          visibleImages.addAll(_newPage);
        });
      }
    });
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
  void dispose() {
    _cachedIndexes.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
          child: Scrollbar(
            controller: _scrollController,
        radius: const Radius.circular(2),
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(8.0),
          itemCount: visibleImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.columnNum == 0
                ? (constraints.maxWidth - 16) ~/ 160
                : widget.columnNum,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) => _suitCover(context, index),
        ),
      ));
    });
  }

  GestureDetector _suitCover(BuildContext context, int index) {
    _preloadImage(index + coverCacheStep);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CustomRoute.viewPage,
            arguments: widget.images[index]);
      },
      child: CachedNetworkImage(
        imageUrl: visibleImages[index],
        fadeInDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  Iterable<String> get _newPage {
    var start = _page * pageSize;
    var end = min((_page + 1) * pageSize, widget.images.length);
    return widget.images
        .getRange(start, end)
        .map((e) => getCoverURL(e.id, e.prefix));
  }
}
