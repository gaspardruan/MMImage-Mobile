import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmimage_mobile/utils.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key, required this.images});

  final List<String> images;

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final HashSet<int> _cachedIndexes = HashSet<int>();
  int pageIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImage(0, cacheStep);
  }

  void _preloadImage(int start, [int step = 1]) {
    if (start < 0 || start >= widget.images.length) {
      return;
    }
    final int end = min(widget.images.length, start + step);
    for (int i = start; i < end; i++) {
      if (!_cachedIndexes.contains(i)) {
        final String url = widget.images[i];
        // precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);
        precacheImage(CachedNetworkImageProvider(url), context);
        _cachedIndexes.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          Icon(CupertinoIcons.back, size: 16),
          Text("${pageIndex + 1} / ${widget.images.length}",
              style: TextStyle(fontSize: 10))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: _photoPageView(),
    );
  }

  PhotoViewGallery _photoPageView() {
    return PhotoViewGallery.builder(
      allowImplicitScrolling: true,
      wantKeepAlive: true,
      itemCount: widget.images.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(widget.images[index]),
        );
      },
      backgroundDecoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      pageController: PageController(
        initialPage: pageIndex,
      ),
      onPageChanged: (index) {
        if (index > pageIndex) {
          _preloadImage(index + cacheStep - 1);
        }
        setState(() {
          pageIndex = index;
        });
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
